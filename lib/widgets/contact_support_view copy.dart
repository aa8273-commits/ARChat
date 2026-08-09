import 'package:chatt/widgets/contact_form.dart';
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

        body: ContactForm(
          formKey: formKey,
          nameController: nameController,
          emailController: emailController,
          subjectController: subjectController,
          messageController: messageController,
        ),
      ),
    );
  }
}
