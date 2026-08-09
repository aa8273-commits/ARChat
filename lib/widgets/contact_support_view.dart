import 'package:flutter/material.dart';

class ContactSupportView extends StatefulWidget {
  const ContactSupportView({super.key});

  static const String id = "contact_support";

  @override
  State<ContactSupportView> createState() => _ContactSupportViewState();
}

class _ContactSupportViewState extends State<ContactSupportView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xff08131F),
        appBar: AppBar(
          backgroundColor: const Color(0xff0F2742),
          centerTitle: true,
          title: const Text(
            "التواصل مع الدعم",
            style: TextStyle(color: Colors.white),
          ),
        ),

        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              buildField(
                controller: nameController,
                label: "الاسم",
                icon: Icons.person,
              ),

              const SizedBox(height: 15),

              buildField(
                controller: emailController,
                label: "البريد الإلكتروني",
                icon: Icons.email,
              ),

              const SizedBox(height: 15),

              buildField(
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
                  prefixIcon: const Icon(
                    Icons.message,
                    color: Colors.orangeAccent,
                  ),
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
        ),
      ),
    );
  }

  Widget buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.orangeAccent),
        filled: true,
        fillColor: const Color(0xff0F2742),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "هذا الحقل مطلوب";
        }
        return null;
      },
    );
  }
}
