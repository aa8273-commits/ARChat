import 'package:flutter/material.dart';

class GroupUserTile extends StatelessWidget {
  const GroupUserTile({
    super.key,
    required this.user,
    required this.isSelected,
    required this.cardColor,
    required this.onChanged,
  });

  final Map<String, dynamic> user;
  final bool isSelected;
  final Color cardColor;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final String name = user['name'] ?? 'Unknown';
    final String image = user['image'] ?? '';
    final String email = user['email'] ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: CheckboxListTile(
        value: isSelected,
        activeColor: Colors.orangeAccent,
        checkColor: Colors.black,
        onChanged: onChanged,

        secondary: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white10,
          backgroundImage: image.isNotEmpty ? NetworkImage(image) : null,
          child: image.isEmpty
              ? const Icon(Icons.person, color: Colors.white70)
              : null,
        ),

        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(email, style: const TextStyle(color: Colors.white54)),
      ),
    );
  }
}
