import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  static String id = "notifications";

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xff08131F),

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await deleteAllNotifications(currentUser!.uid);
            },
            icon: const Icon(Icons.delete_sweep, color: Colors.white),
          ),
        ],
        backgroundColor: const Color(0xff08131F),
        elevation: 0,

        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("notifications")
            .doc(currentUser!.uid)
            .collection("items")
            .orderBy("createdAt", descending: true)
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No notifications",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            );
          }

          final notifications = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(20),

            itemCount: notifications.length,

            itemBuilder: (context, index) {
              final data = notifications[index].data() as Map<String, dynamic>;

              return Container(
                margin: const EdgeInsets.only(bottom: 15),

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.08),

                  borderRadius: BorderRadius.circular(18),
                ),

                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.orangeAccent,

                    child: Icon(Icons.message, color: Colors.white),
                  ),

                  title: Text(
                    data["title"] ?? "",

                    style: const TextStyle(
                      color: Colors.white,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    data["body"] ?? "",

                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> deleteAllNotifications(String uid) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("notifications")
        .doc(uid)
        .collection("items")
        .get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
