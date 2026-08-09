import 'package:chatt/view/login_view.dart';
import 'package:chatt/widgets/onboarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pageViewonboarding extends StatelessWidget {
  const pageViewonboarding({
    super.key,
    required this.controller,
    required this.pages,
  });

  final PageController controller;
  final List<Map<String, String>> pages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        itemCount: pages.length,
        onPageChanged: (index) {
          if (index == pages.length - 1) {
            Future.delayed(const Duration(seconds: 2), () async {
              final prefs = await SharedPreferences.getInstance();

              await prefs.setBool("onboarding_done", true);

              if (!context.mounted) return;

              Navigator.pushReplacementNamed(context, LoginView.id);
            });
          }
        },
        itemBuilder: (context, index) {
          return OnboardingWidget(pages: pages, index: index);
        },
      ),
    );
  }
}
