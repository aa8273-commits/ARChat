import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  static const String id = "privacy_policy";

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
            "سياسة الخصوصية",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "سياسة الخصوصية",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              Text(
                "نحن في تطبيق Chatt نلتزم بحماية خصوصية جميع المستخدمين، ونعمل على الحفاظ على بياناتهم الشخصية بأعلى مستويات الأمان.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),

              SizedBox(height: 25),

              Text(
                "1. المعلومات التي نقوم بجمعها",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "• الاسم.\n"
                "• البريد الإلكتروني.\n"
                "• صورة الملف الشخصي (في حالة إضافتها).\n"
                "• الرسائل والبيانات المتعلقة باستخدام التطبيق.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),

              SizedBox(height: 25),

              Text(
                "2. كيفية استخدام البيانات",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "يتم استخدام البيانات لتحسين تجربة المستخدم، وتوفير خدمات التطبيق، وحماية الحسابات من الاستخدام غير المصرح به.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),

              SizedBox(height: 25),

              Text(
                "3. حماية البيانات",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "نستخدم وسائل حماية مناسبة لتأمين بيانات المستخدمين، ولا تتم مشاركة المعلومات الشخصية مع أي طرف ثالث دون موافقة المستخدم، إلا إذا كان ذلك مطلوبًا بموجب القانون.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),

              SizedBox(height: 25),

              Text(
                "4. حقوق المستخدم",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "يحق للمستخدم تعديل بياناته الشخصية أو حذف حسابه في أي وقت من خلال إعدادات التطبيق.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),

              SizedBox(height: 25),

              Text(
                "5. التعديلات على السياسة",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "قد يتم تحديث سياسة الخصوصية من وقت لآخر، وسيتم إعلام المستخدمين بأي تغييرات جوهرية داخل التطبيق.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),

              SizedBox(height: 30),

              Center(
                child: Text(
                  "آخر تحديث: أغسطس 2026",
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
