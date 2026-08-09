import 'package:chatt/widgets/_MemberTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupInfoView extends StatelessWidget {
  const GroupInfoView({super.key, required this.conversationId});
  static String id = 'group_info_view';
  final String conversationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff08131F),
      appBar: AppBar(
        backgroundColor: const Color(0xff0F2742),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "معلومات المجموعة",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("conversations")
            .doc(conversationId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.orangeAccent),
            );
          }

          if (!snapshot.hasData ||
              !snapshot.data!.exists ||
              snapshot.data!.data() == null) {
            return const Center(
              child: Text(
                "المجموعة غير موجودة",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          final String groupName = data["name"]?.toString() ?? "Group";

          final String groupImage = data["image"]?.toString() ?? "";

          final String createdBy = data["createdBy"]?.toString() ?? "";

          final members = Map<String, dynamic>.from(data["members"] ?? {});

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 10),

              // =========================
              // GROUP IMAGE
              // =========================
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color(0xff0F2742),
                  backgroundImage: groupImage.isNotEmpty
                      ? NetworkImage(groupImage)
                      : null,
                  child: groupImage.isEmpty
                      ? const Icon(
                          Icons.groups,
                          color: Colors.orangeAccent,
                          size: 55,
                        )
                      : null,
                ),
              ),

              const SizedBox(height: 18),

              Center(
                child: Text(
                  groupName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: Text(
                  "${members.length} أعضاء",
                  style: const TextStyle(color: Colors.white60, fontSize: 14),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "أعضاء المجموعة",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              ...members.keys.map((memberId) {
                return MemberTile(
                  uid: memberId,
                  isAdmin: memberId == createdBy,
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
