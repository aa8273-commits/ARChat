import 'package:flutter/material.dart';

Widget emptyState() {
  return Container(
    padding: const EdgeInsets.all(25),
    decoration: BoxDecoration(
      color: const Color(0xff0F2742),
      borderRadius: BorderRadius.circular(25),
    ),
    child: const Column(
      children: [
        Icon(Icons.auto_stories, size: 60, color: Colors.orange),

        SizedBox(height: 15),

        Text(
          "لا توجد حالات",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text("كن أول من يشارك لحظة", style: TextStyle(color: Colors.white70)),
      ],
    ),
  );
}
