import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoryRepliesView extends StatelessWidget {
  final String updateId;

  const StoryRepliesView({super.key, required this.updateId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff08131F),

      appBar: AppBar(
        backgroundColor: const Color(0xff0F2742),
        title: const Text(
          "Story Replies",
          style: TextStyle(color: Colors.orangeAccent),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("updates")
            .doc(updateId)
            .collection("replies")
            .orderBy("createdAt", descending: true)
            .snapshots(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final replies = snapshot.data!.docs;

          if (replies.isEmpty) {
            return const Center(
              child: Text(
                "No replies yet",
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          return ListView.builder(
            itemCount: replies.length,

            itemBuilder: (context, index) {
              final data = replies[index].data() as Map<String, dynamic>;

              return ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      data["senderImage"] != null &&
                          data["senderImage"].toString().isNotEmpty
                      ? NetworkImage(data["senderImage"])
                      : null,

                  child:
                      data["senderImage"] == null ||
                          data["senderImage"].toString().isEmpty
                      ? const Icon(Icons.person)
                      : null,
                ),

                title: Text(
                  data["senderName"] ?? "User",
                  style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  data["message"] ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),

                trailing: Text(
                  "Reply",
                  style: TextStyle(color: Colors.white54),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
