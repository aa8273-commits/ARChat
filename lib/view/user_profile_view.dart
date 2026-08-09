import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key, required this.uid});

  static const String id = "user_profile";

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff08131F),
      appBar: AppBar(
        backgroundColor: const Color(0xff0F2742),
        centerTitle: true,
        title: const Text(
          "الملف الشخصي",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text(
                "المستخدم غير موجود",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final rawData = snapshot.data!.data();

          if (rawData == null) {
            return const Center(
              child: Text(
                "لا توجد بيانات",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final data = rawData as Map<String, dynamic>;

          final image = data["image"] ?? "";
          final name = data["name"] ?? "";
          final email = data["email"] ?? "";
          final bio = data["bio"] ?? "";
          final online = data["isOnline"] ?? false;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 20),

              Center(
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.white24,
                  backgroundImage: image.isNotEmpty
                      ? NetworkImage(image)
                      : null,
                  child: image.isEmpty
                      ? const Icon(Icons.person, size: 70, color: Colors.white)
                      : null,
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: Text(
                  online ? "🟢 متصل الآن" : "⚫ غير متصل",
                  style: TextStyle(
                    color: online ? Colors.green : Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff0F2742),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "البريد الإلكتروني",
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(email, style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff0F2742),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "النبذة الشخصية",
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      bio.isEmpty ? "لا توجد نبذة شخصية." : bio,
                      style: const TextStyle(
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.chat, color: Colors.white),
                  label: const Text(
                    "العودة إلى المحادثة",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
