import 'package:flutter/material.dart';

class UpdateTextField extends StatelessWidget {
  const UpdateTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Color(0xff0F2742),

        borderRadius: BorderRadius.circular(20),
      ),

      child: TextField(
        controller: controller,

        maxLines: 5,

        style: const TextStyle(color: Colors.white),

        decoration: const InputDecoration(
          hintText: "Write an update...",

          border: InputBorder.none,
        ),
      ),
    );
  }
}
