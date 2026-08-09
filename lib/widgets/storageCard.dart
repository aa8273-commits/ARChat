import 'package:flutter/material.dart';

Widget storageCard(IconData icon, String title, String size) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xff0F2742),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.orange.withOpacity(.15),
          child: Icon(icon, color: Colors.orange),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
        Text(size, style: const TextStyle(color: Colors.white70)),
      ],
    ),
  );
}
