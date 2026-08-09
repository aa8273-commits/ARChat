import 'package:flutter/material.dart';

Widget switchTile(
  String title,
  IconData icon,
  bool value,
  Function(bool) onChanged,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: const Color(0xff0F2742),
      borderRadius: BorderRadius.circular(18),
    ),
    child: SwitchListTile(
      activeColor: const Color(0xffffa500),
      value: value,
      onChanged: onChanged,
      secondary: Icon(icon, color: const Color(0xffffa500)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
    ),
  );
}
