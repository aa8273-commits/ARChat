import 'package:flutter/material.dart';

void showAboutDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xff0F2742),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (_) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ListView(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.orangeAccent,
                child: Icon(Icons.chat, color: Colors.white, size: 40),
              ),

              const SizedBox(height: 20),

              const Text(
                "شات",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "الإصدار 1.0.0",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),

              const SizedBox(height: 20),

              const Text(
                "Chatt هو تطبيق مراسلة فورية يتيح لك التواصل مع أصدقائك بسهولة وسرعة. تم تطوير التطبيق باستخدام Flutter وFirebase لتوفير تجربة استخدام حديثة وآمنة مع أداء سريع وواجهة بسيطة وسهلة الاستخدام.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  height: 1.7,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 25),

              const Divider(color: Colors.white24),

              const SizedBox(height: 10),

              const Text(
                "© 2026 Chatt",
                style: TextStyle(color: Colors.white54),
              ),

              const SizedBox(height: 5),

              const Text(
                "تم تطوير التطبيق باستخدام Flutter ❤️",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}
