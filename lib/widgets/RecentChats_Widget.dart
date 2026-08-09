import 'package:chatt/helper/formatMessageDate.dart';
import 'package:chatt/view/chat_view.dart';
import 'package:chatt/widgets/chat_tile.dart';
// import 'package:chatt/widgets/group_info_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecentChatsWidget extends StatelessWidget {
  const RecentChatsWidget({super.key, required this.searchText});

  final String searchText;

  static const String id = "RecentChatsWidget";

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Center(
        child: Text("يجب تسجيل الدخول", style: TextStyle(color: Colors.white)),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("conversations")
          .orderBy("lastTime", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("حدث خطأ", style: TextStyle(color: Colors.white)),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.orangeAccent),
          );
        }

        final conversations = snapshot.data!.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;

          final members = Map<String, dynamic>.from(data["members"] ?? {});

          return members.containsKey(currentUser.uid);
        }).toList();

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          itemCount: conversations.length + 1,
          separatorBuilder: (_, __) {
            return const Divider(
              color: Colors.white10,
              indent: 85,
              endIndent: 20,
              height: 1,
            );
          },
          itemBuilder: (context, index) {
            // =========================
            // HEADER
            // =========================

            if (index == 0) {
              return Container(
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff0F2742),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent.withOpacity(.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.chat_bubble_rounded,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Recent Chats",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "آخر المحادثات",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${conversations.length}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            final conversation = conversations[index - 1];

            final conversationData =
                conversation.data() as Map<String, dynamic>;

            final String type = conversationData["type"] ?? "private";

            if (type == "group") {
              final String groupName =
                  conversationData["name"]?.toString() ?? "Group";

              final String groupImage =
                  conversationData["image"]?.toString() ?? "";

              final String lastMessage =
                  conversationData["lastMessage"]?.toString() ?? "";

              final Timestamp? lastTime = conversationData["lastTime"];

              if (searchText.isNotEmpty &&
                  !groupName.toLowerCase().contains(searchText.toLowerCase())) {
                return const SizedBox.shrink();
              }

              return ChatTile(
                uid: conversation.id,
                image: groupImage,
                name: groupName,
                message: lastMessage.isEmpty
                    ? "لا توجد رسائل بعد"
                    : lastMessage,
                time: lastTime != null ? formatMessageTime(lastTime) : "",
                status: "",
                unread: 0,
                online: false,

                // مهم جدًا
                isGroup: true,
                conversationId: conversation.id,

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatView(
                        conversationId: conversation.id,
                        receiverId: "",
                        receiverName: groupName,
                        receiverImage: groupImage,
                        isGroup: true,
                      ),
                    ),
                  );
                },
              );
            }

            final members = Map<String, dynamic>.from(
              conversationData["members"] ?? {},
            );

            members.remove(currentUser.uid);

            if (members.isEmpty) {
              return const SizedBox.shrink();
            }

            final String otherUserId = members.keys.first;

            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection("users")
                  .doc(otherUserId)
                  .get(),
              builder: (context, userSnapshot) {
                if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                  return const SizedBox();
                }

                final data = userSnapshot.data!.data() as Map<String, dynamic>;

                final String name = data["name"] ?? "";

                if (searchText.isNotEmpty &&
                    !name.toLowerCase().contains(searchText.toLowerCase())) {
                  return const SizedBox.shrink();
                }

                final String? lastMessageId = conversationData["lastMessageId"];

                if (lastMessageId == null || lastMessageId.isEmpty) {
                  return ChatTile(
                    uid: otherUserId,
                    image: data["image"] ?? "",
                    name: name,
                    message: "لا توجد رسائل بعد",
                    time: "",
                    status: "",
                    unread: 0,
                    online: data["isOnline"] ?? false,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatView(
                            conversationId: conversation.id,
                            receiverId: otherUserId,
                            receiverName: name,
                            receiverImage: data["image"] ?? "",
                            isGroup: false,
                          ),
                        ),
                      );
                    },
                  );
                }

                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("conversations")
                      .doc(conversation.id)
                      .collection("messages")
                      .doc(lastMessageId)
                      .get(),
                  builder: (context, messageSnapshot) {
                    String status = "";

                    if (messageSnapshot.hasData &&
                        messageSnapshot.data!.exists) {
                      final messageData =
                          messageSnapshot.data!.data() as Map<String, dynamic>;

                      if (conversationData["lastSenderId"] == currentUser.uid) {
                        status = messageData["status"] ?? "sent";
                      }
                    }

                    final Timestamp? lastTime = conversationData["lastTime"];

                    return ChatTile(
                      uid: otherUserId,
                      image: data["image"] ?? "",
                      name: name,
                      message: conversationData["lastMessage"] ?? "",
                      time: lastTime != null ? formatMessageTime(lastTime) : "",
                      status: status,
                      unread: 0,
                      online: data["isOnline"] ?? false,

                      // Private
                      isGroup: false,
                      conversationId: conversation.id,

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatView(
                              conversationId: conversation.id,
                              receiverId: otherUserId,
                              receiverName: name,
                              receiverImage: data["image"] ?? "",
                              isGroup: false,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
