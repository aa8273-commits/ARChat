import 'package:chatt/Services/Conversation_Service.dart';
import 'package:chatt/view/chat_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  static const String id = "contacts";

  @override
  Widget build(BuildContext context) {
    final currentUid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: const Color(0xff08131F),
      appBar: AppBar(
        backgroundColor: const Color(0xff0F2742),
        centerTitle: true,
        title: const Text(
          "جهات الاتصال",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs
              .where((e) => e.id != currentUid)
              .toList();

          if (users.isEmpty) {
            return const Center(
              child: Text(
                "لا يوجد مستخدمون",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final data = users[index].data() as Map<String, dynamic>;

              final image = data["image"] ?? "";
              final name = data["name"] ?? "";
              final email = data["email"] ?? "";

              return Card(
                color: const Color(0xff0F2742),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: image.isNotEmpty
                        ? NetworkImage(image)
                        : null,
                    child: image.isEmpty ? const Icon(Icons.person) : null,
                  ),

                  title: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    email,
                    style: const TextStyle(color: Colors.white70),
                  ),

                  trailing: const Icon(Icons.chat, color: Colors.orangeAccent),

                  onTap: () async {
                    final conversationId = await ConversationService()
                        .createOrGetConversation(
                          FirebaseAuth.instance.currentUser!.uid,
                          users[index].id,
                        );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatView(
                          conversationId: conversationId,
                          receiverId: users[index].id,
                          receiverName: name,
                          receiverImage: image,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
