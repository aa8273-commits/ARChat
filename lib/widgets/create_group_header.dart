import 'dart:io';

import 'package:flutter/material.dart';

class CreateGroupHeader extends StatelessWidget {
  const CreateGroupHeader({
    super.key,
    required this.groupImage,
    required this.groupNameController,
    required this.cardColor,
    required this.onPickImage,
  });

  final File? groupImage;
  final TextEditingController groupNameController;
  final Color cardColor;
  final VoidCallback onPickImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          GestureDetector(
            onTap: onPickImage,
            child: CircleAvatar(
              radius: 38,
              backgroundColor: cardColor,
              backgroundImage: groupImage != null
                  ? FileImage(groupImage!)
                  : null,
              child: groupImage == null
                  ? const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.orangeAccent,
                      size: 30,
                    )
                  : null,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: TextField(
              controller: groupNameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'اسم الجروب',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.group_outlined,
                  color: Colors.orangeAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
