import 'package:chatt/widgets/FAQItem.dart';
import 'package:flutter/material.dart';

class FAQView extends StatelessWidget {
  const FAQView({super.key});

  static const String id = "faq";

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
            "الأسئلة الشائعة",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),

        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            FAQItem(
              question: "كيف يمكنني تغيير صورة الملف الشخصي؟",
              answer:
                  "افتح صفحة الملف الشخصي، ثم اضغط على أيقونة الكاميرا واختر المعرض أو الكاميرا.",
            ),

            FAQItem(
              question: "كيف يمكنني تغيير اسمي؟",
              answer:
                  "انتقل إلى صفحة تعديل الملف الشخصي ثم قم بتغيير الاسم وحفظ التعديلات.",
            ),

            FAQItem(
              question: "لماذا لا تصلني الرسائل؟",
              answer:
                  "تأكد من اتصالك بالإنترنت، وتحقق من تفعيل الإشعارات داخل التطبيق.",
            ),

            FAQItem(
              question: "كيف يمكنني حظر مستخدم؟",
              answer: "افتح الملف الشخصي للمستخدم ثم اختر خيار حظر المستخدم.",
            ),

            FAQItem(
              question: "هل يمكنني حذف حسابي؟",
              answer:
                  "نعم، يمكنك ذلك من خلال الإعدادات ثم الخصوصية ثم حذف الحساب.",
            ),

            FAQItem(
              question: "كيف يمكنني الإبلاغ عن مشكلة؟",
              answer:
                  "انتقل إلى صفحة المساعدة والدعم ثم اختر الإبلاغ عن مشكلة.",
            ),

            FAQItem(
              question: "هل بياناتي آمنة؟",
              answer:
                  "نعم، يتم حفظ بياناتك بشكل آمن باستخدام خدمات Firebase مع تطبيق قواعد الحماية المناسبة.",
            ),
          ],
        ),
      ),
    );
  }
}
