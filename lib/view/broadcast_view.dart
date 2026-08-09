import 'package:chatt/widgets/BroadcastCard.dart';
import 'package:flutter/material.dart';

class BroadcastView extends StatelessWidget {
  const BroadcastView({super.key});

  static const String id = "/broadcast";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff08131F),

      appBar: AppBar(
        backgroundColor: const Color(0xff0F2742),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "البث",
          style: TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xff0F2742),
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Row(
                children: [
                  Icon(Icons.campaign, color: Colors.orangeAccent, size: 35),

                  SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "إنشاء بث جديد",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          "أرسل نفس الرسالة لعدة أشخاص في وقت واحد.",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "عمليات البث السابقة",
              style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView(
                children: const [
                  BroadcastCard(
                    title: "إعلان التطبيق",
                    users: "24",
                    time: "اليوم 8:30 م",
                  ),

                  BroadcastCard(title: "عرض الجمعة", users: "12", time: "أمس"),

                  BroadcastCard(
                    title: "تحديث جديد",
                    users: "48",
                    time: "منذ 3 أيام",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
