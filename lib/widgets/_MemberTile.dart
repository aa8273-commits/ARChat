import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MemberTile extends StatelessWidget {
  const MemberTile({required this.uid, required this.isAdmin});

  final String uid;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            !snapshot.data!.exists ||
            snapshot.data!.data() == null) {
          return const SizedBox();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        final String name = data["name"]?.toString() ?? "Unknown";

        final String image = data["image"]?.toString() ?? "";

        final bool online = data["isOnline"] ?? false;

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: const Color(0xff0F2742),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 5,
            ),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white24,
              backgroundImage: image.isNotEmpty ? NetworkImage(image) : null,
              child: image.isEmpty
                  ? const Icon(Icons.person, color: Colors.white)
                  : null,
            ),
            title: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              online ? "متصل الآن" : "غير متصل",
              style: TextStyle(
                color: online ? Colors.greenAccent : Colors.white54,
                fontSize: 12,
              ),
            ),
            trailing: isAdmin
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent.withOpacity(.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Admin",
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }
}
