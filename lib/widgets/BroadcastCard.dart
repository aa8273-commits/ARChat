import 'package:flutter/material.dart';

class BroadcastCard extends StatelessWidget {
  final String title;
  final String users;
  final String time;

  const BroadcastCard({
    super.key,
    required this.title,
    required this.users,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xff0F2742),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.orangeAccent,
            child: const Icon(Icons.campaign, color: Colors.white),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "تم الإرسال إلى $users شخص",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(color: Colors.white60, fontSize: 12),
              ),

              const SizedBox(height: 10),

              Icon(
                Icons.arrow_forward_ios,
                color: Colors.orangeAccent,
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
