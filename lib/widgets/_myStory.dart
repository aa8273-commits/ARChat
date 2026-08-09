import 'package:chatt/view/AddUpdateView.dart';
import 'package:flutter/material.dart';

Widget myStory(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddUpdateView()),
      );
    },
    child: Container(
      width: 85,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orangeAccent, width: 3),
            ),
            child: CircleAvatar(
              radius: 34,
              backgroundColor: Colors.grey[800],
              child: Icon(Icons.add, size: 35, color: Colors.orangeAccent),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "حالتي",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    ),
  );
}
