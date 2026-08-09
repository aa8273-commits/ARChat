import 'package:chatt/widgets/buildField_Contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.subjectController,
    required this.messageController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController subjectController;
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          buildFieldContact(
            controller: nameController,
            label: "الاسم",
            icon: Icons.person,
          ),

          const SizedBox(height: 15),

          buildFieldContact(
            controller: emailController,
            label: "البريد الإلكتروني",
            icon: Icons.email,
          ),

          const SizedBox(height: 15),

          buildFieldContact(
            controller: subjectController,
            label: "عنوان الرسالة",
            icon: Icons.title,
          ),

          const SizedBox(height: 15),

          TextFormField(
            controller: messageController,
            maxLines: 6,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "اكتب رسالتك هنا...",
              hintStyle: const TextStyle(color: Colors.white54),
              prefixIcon: const Icon(Icons.message, color: Colors.orangeAccent),
              filled: true,
              fillColor: const Color(0xff0F2742),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "يرجى كتابة الرسالة";
              }
              return null;
            },
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("تم إرسال رسالتك بنجاح")),
                  );
                }
              },
              child: const Text(
                "إرسال",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
