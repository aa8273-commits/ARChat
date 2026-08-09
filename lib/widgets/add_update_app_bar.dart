import 'package:flutter/material.dart';

class AddUpdateAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddUpdateAppBar({super.key, required this.onPost});

  final VoidCallback onPost;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: const Color(0xff08131F),
      title: const Text(
        "Add Update",
        style: TextStyle(color: Colors.orangeAccent),
      ),
      actions: [
        TextButton(
          onPressed: onPost,
          child: const Text(
            "Post",
            style: TextStyle(
              color: Color(0xffff8c00),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
