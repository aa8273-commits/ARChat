import 'package:flutter/material.dart';

class ReportBugView extends StatefulWidget {
  const ReportBugView({super.key});

  static const String id = "report_bug";

  @override
  State<ReportBugView> createState() => _ReportBugViewState();
}

class _ReportBugViewState extends State<ReportBugView> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String selectedCategory = "الرسائل";

  final List<String> categories = [
    "الرسائل",
    "الإشعارات",
    "الملف الشخصي",
    "تسجيل الدخول",
    "الصور",
    "الصوت",
    "الفيديو",
    "أخرى",
  ];

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
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
            "الإبلاغ عن مشكلة",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                "نوع المشكلة",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: selectedCategory,
                dropdownColor: const Color(0xff0F2742),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff0F2742),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                items: categories.map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: titleController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "عنوان المشكلة",
                  labelStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(
                    Icons.title,
                    color: Colors.orangeAccent,
                  ),
                  filled: true,
                  fillColor: const Color(0xff0F2742),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? "أدخل عنوان المشكلة" : null,
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: descriptionController,
                maxLines: 7,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "اشرح المشكلة بالتفصيل...",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xff0F2742),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? "اكتب وصف المشكلة" : null,
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.send, color: Colors.white),
                  label: const Text(
                    "إرسال البلاغ",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("تم إرسال البلاغ بنجاح ✅"),
                        ),
                      );

                      titleController.clear();
                      descriptionController.clear();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
