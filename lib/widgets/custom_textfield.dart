import 'package:flutter/material.dart';

class CustomFromTextField extends StatelessWidget {
  const CustomFromTextField({
    super.key,
    this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.icon,
    this.suffixIcon,
    this.onSuffixPressed,
    this.keyboardType,
  });

  final String? hintText;
  final Function(String)? onChanged;
  final bool obscureText;
  final IconData? icon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixPressed;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      onChanged: onChanged,

      validator: (data) {
        if (data == null || data.trim().isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white60, fontSize: 15),

        floatingLabelBehavior: FloatingLabelBehavior.never,

        filled: true,
        fillColor: Colors.white.withOpacity(.08),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),

        prefixIcon: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),

        suffixIcon: suffixIcon == null
            ? null
            : IconButton(
                onPressed: onSuffixPressed,
                icon: Icon(suffixIcon, color: Colors.white70),
              ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.white.withOpacity(.18)),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.red),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
