import 'package:flutter/material.dart';

class EditProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditProfileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff0F2742),
      centerTitle: true,
      title: const Text(
        "تعديل الملف الشخصي",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
