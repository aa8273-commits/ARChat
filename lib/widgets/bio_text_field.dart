import 'package:flutter/material.dart';

class BioTextField extends StatelessWidget {
  const BioTextField({super.key, required this.bioController});

  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: bioController,
      maxLines: 3,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "النبذة الشخصية",
        hintText: "اكتب نبذة عن نفسك...",
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: const Icon(Icons.info_outline, color: Colors.orangeAccent),
        filled: true,
        fillColor: const Color(0xff0F2742),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
