import 'package:flutter/material.dart';

class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});

  static const String id = "terms_conditions";

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
            "الشروط والأحكام",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "الشروط والأحكام",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              Text(
                "مرحبًا بك في تطبيق Chatt. باستخدامك لهذا التطبيق فإنك توافق على الالتزام بالشروط والأحكام التالية.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),

              SizedBox(height: 25),

              Text(
                "1. استخدام التطبيق",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "يجب استخدام التطبيق بطريقة قانونية ومسؤولة، ويُمنع استخدامه في أي نشاط يسبب ضررًا للمستخدمين أو يخالف القوانين.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),

              SizedBox(height: 25),

              Text(
                "2. مسؤولية المستخدم",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "المستخدم مسؤول عن حماية بيانات تسجيل الدخول الخاصة به، وعدم مشاركة كلمة المرور مع أي شخص.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),

              SizedBox(height: 25),

              Text(
                "3. المحتوى",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "يُمنع إرسال أي محتوى مسيء أو مخالف للقانون أو ينتهك حقوق الآخرين، ويحق لإدارة التطبيق اتخاذ الإجراءات المناسبة عند المخالفة.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),

              SizedBox(height: 25),

              Text(
                "4. الخصوصية",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "يتم التعامل مع بيانات المستخدم وفقًا لسياسة الخصوصية الخاصة بالتطبيق، ونلتزم بحماية معلوماتك الشخصية.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),

              SizedBox(height: 25),

              Text(
                "5. تحديث الشروط",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "قد يتم تحديث هذه الشروط والأحكام من وقت لآخر، ويُعد استمرار استخدام التطبيق بعد نشر التحديثات موافقةً عليها.",
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
