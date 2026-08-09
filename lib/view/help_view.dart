import 'package:chatt/view/privacy_policy_view.dart';
import 'package:chatt/widgets/contact_support_view.dart'
    show ContactSupportView;
import 'package:chatt/widgets/faq_view.dart';
import 'package:chatt/widgets/feedback_view.dart';
import 'package:chatt/widgets/help_buildTile.dart';
import 'package:chatt/widgets/report_bug_view.dart';
import 'package:chatt/widgets/terms_conditions_view.dart';
import 'package:flutter/material.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  static const String id = "help";

  @override
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xff08131F),
        appBar: AppBar(
          backgroundColor: const Color(0xff0F2742),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "المساعدة والدعم",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            buildTile(
              icon: Icons.help_outline,
              title: "الأسئلة الشائعة",
              subtitle: "اعثر على إجابات للأسئلة الأكثر شيوعًا.",
              onTap: () {
                Navigator.pushNamed(context, FAQView.id);
              },
            ),

            buildTile(
              icon: Icons.support_agent,
              title: "التواصل مع الدعم",
              subtitle: "تواصل مع فريق الدعم الفني.",
              onTap: () {
                Navigator.pushNamed(context, ContactSupportView.id);
              },
            ),

            buildTile(
              icon: Icons.bug_report_outlined,
              title: "الإبلاغ عن مشكلة",
              subtitle: "أخبرنا بأي مشكلة تواجهها.",
              onTap: () {
                Navigator.pushNamed(context, ReportBugView.id);
              },
            ),

            buildTile(
              icon: Icons.feedback_outlined,
              title: "إرسال اقتراح",
              subtitle: "شاركنا أفكارك وملاحظاتك لتحسين التطبيق.",
              onTap: () {
                Navigator.pushNamed(context, FeedbackView.id);
              },
            ),

            buildTile(
              icon: Icons.privacy_tip_outlined,
              title: "سياسة الخصوصية",
              subtitle: "اطلع على سياسة الخصوصية الخاصة بالتطبيق.",
              onTap: () {
                Navigator.pushNamed(context, PrivacyPolicyView.id);
              },
            ),

            buildTile(
              icon: Icons.description_outlined,
              title: "الشروط والأحكام",
              subtitle: "اقرأ شروط وأحكام استخدام التطبيق.",
              onTap: () {
                Navigator.pushNamed(context, TermsConditionsView.id);
              },
            ),

            buildTile(
              icon: Icons.info_outline,
              title: "حول التطبيق",
              subtitle: "معلومات عن تطبيق Chatt.",
              onTap: () {
                showAboutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void showAboutDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff0F2742),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ListView(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.orangeAccent,
                  child: Icon(Icons.chat, color: Colors.white, size: 40),
                ),

                const SizedBox(height: 20),

                const Text(
                  "شات",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "الإصدار 1.0.0",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Chatt هو تطبيق مراسلة فورية يتيح لك التواصل مع أصدقائك بسهولة وسرعة. تم تطوير التطبيق باستخدام Flutter وFirebase لتوفير تجربة استخدام حديثة وآمنة مع أداء سريع وواجهة بسيطة وسهلة الاستخدام.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    height: 1.7,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 25),

                const Divider(color: Colors.white24),

                const SizedBox(height: 10),

                const Text(
                  "© 2026 Chatt",
                  style: TextStyle(color: Colors.white54),
                ),

                const SizedBox(height: 5),

                const Text(
                  "تم تطوير التطبيق باستخدام Flutter ❤️",
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
