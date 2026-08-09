import 'package:chatt/view/profile_view.dart';
import 'package:chatt/widgets/group_info_widget.dart';
// import 'package:chatt/view/group_info_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatUserInfo extends StatelessWidget {
  const ChatUserInfo({
    super.key,
    required this.receiverId,
    required this.conversationId,
    required this.isGroup,
  });

  final String receiverId;
  final String conversationId;
  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    if (isGroup) {
      return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('conversations')
            .doc(conversationId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data?.data() == null) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            GroupInfoView(conversationId: conversationId),
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.group, color: Colors.white),
                  ),
                ),

                const SizedBox(width: 10),

                const Text(
                  'Group',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          final String groupName =
              data['name']?.toString().trim().isNotEmpty == true
              ? data['name'].toString()
              : 'Group';

          final String groupImage = data['image']?.toString() ?? '';

          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          GroupInfoView(conversationId: conversationId),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white24,
                  backgroundImage: groupImage.isNotEmpty
                      ? NetworkImage(groupImage)
                      : null,
                  child: groupImage.isEmpty
                      ? const Icon(Icons.group, color: Colors.white)
                      : null,
                ),
              ),

              const SizedBox(width: 10),

              Flexible(
                child: Text(
                  groupName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data?.data() == null) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ProfileView.id,
                    arguments: receiverId,
                  );
                },
                child: const CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ],
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        final String name = data['name']?.toString() ?? 'Unknown';

        final String image = data['image']?.toString() ?? '';

        return Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ProfileView.id,
                  arguments: receiverId,
                );
              },
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white24,
                backgroundImage: image.isNotEmpty ? NetworkImage(image) : null,
                child: image.isEmpty
                    ? const Icon(Icons.person, color: Colors.white)
                    : null,
              ),
            ),

            const SizedBox(width: 10),

            Flexible(
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
