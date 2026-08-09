import 'package:flutter/material.dart';

Widget settingTile({
  required IconData icon,
  required String title,
  required String subtitle,
  VoidCallback? onTap,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),

    decoration: BoxDecoration(
      color: const Color(0xff0F2742),
      borderRadius: BorderRadius.circular(16),
    ),

    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),

      leading: CircleAvatar(
        backgroundColor: const Color(0xff163B5F),
        child: Icon(icon, color: Colors.orangeAccent),
      ),

      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),

      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white60, fontSize: 12),
      ),

      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 15,
        color: Colors.white,
      ),

      onTap: onTap,
    ),
  );
}
