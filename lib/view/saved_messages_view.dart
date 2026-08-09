import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SavedMessagesView extends StatelessWidget {
  const SavedMessagesView({super.key});

  static const String id = "savedMessages";

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: const Color(0xff08131F),
      appBar: AppBar(
        backgroundColor: const Color(0xff0F2742),
        title: const Text(
          "Saved Messages",
          style: TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("savedMessages")
            .orderBy("createdAt", descending: true)
            .snapshots(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final messages = snapshot.data!.docs;

          if (messages.isEmpty) {
            return const Center(
              child: Text(
                "No Saved Messages",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,

            itemBuilder: (context, index) {
              final data = messages[index].data() as Map<String, dynamic>;

              return Card(
                color: const Color(0xff0F2742),

                child: ListTile(
                  title: Text(
                    data["text"],
                    style: const TextStyle(color: Colors.white),
                  ),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),

                    onPressed: () async {
                      await messages[index].reference.delete();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
