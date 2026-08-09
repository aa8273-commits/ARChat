import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  static const String id = "about";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff08131F),
      appBar: AppBar(
        backgroundColor: const Color(0xff0F2742),
        centerTitle: true,
        title: const Text(
          "حول التطبيق",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xff0F2742),
              child: Icon(Icons.chat, size: 45, color: Colors.white),
            ),

            const SizedBox(height: 20),

            const Text(
              "AR Chat",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "الإصدار 1.0.0",
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 30),

            const Card(
              color: Color(0xff0F2742),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "AR Chat هو تطبيق محادثات يعتمد على Firebase وCloudinary، يتيح إرسال الرسائل وإدارة الملف الشخصي بطريقة سهلة وسريعة.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const Spacer(),

            const Text(
              "تم التطوير بواسطة",
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 5),

            const Text(
              "AbdulRahman Ahmed Ibrahim",
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
  }
}
