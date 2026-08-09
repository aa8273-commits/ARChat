import 'package:flutter/material.dart';

class AddMediaButton extends StatelessWidget {
  const AddMediaButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffff8c00),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            "Add Photo / Video",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
