import 'package:chatt/widgets/languageTile.dart';
import 'package:flutter/material.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  static const String id = "/language";

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  String selectedLanguage = "ar";

  final Color background = const Color(0xff08131F);
  final Color card = const Color(0xff0F2742);
  final Color orange = Colors.orangeAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "لغة التطبيق",
          style: TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const SizedBox(height: 10),

          const Text(
            "اختر لغة التطبيق",
            style: TextStyle(
              color: Colors.orangeAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          LanguageTile(
            title: "العربية",
            subtitle: "Arabic",
            value: "ar",
            icon: "🇪🇬",
            groupValue: selectedLanguage,
            onChanged: (v) {
              setState(() {
                selectedLanguage = v!;
              });
            },
          ),
          const SizedBox(height: 15),

          LanguageTile(
            title: "English",
            subtitle: "الإنجليزية",
            value: "en",
            icon: "🇺🇸",
            groupValue: selectedLanguage,
            onChanged: (v) {
              setState(() {
                selectedLanguage = v!;
              });
            },
          ),

          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: card,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: Colors.orangeAccent),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "سيتم تطبيق اللغة بعد إعادة تشغيل التطبيق أو عند دعم الترجمة الكاملة.",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
