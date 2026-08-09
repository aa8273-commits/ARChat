import 'package:chatt/view/onboarding_view.dart';
import 'package:chatt/widgets/Splash_widget.dart';

import 'package:flutter/material.dart';

class SplashHomeView extends StatefulWidget {
  const SplashHomeView({super.key});

  static String id = 'SplashHomeView';

  @override
  State<SplashHomeView> createState() => _SplashHomeViewState();
}

class _SplashHomeViewState extends State<SplashHomeView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 60), () {
      if (!mounted) return;

      Navigator.pushReplacementNamed(context, OnboardingHomeView.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Splash_widget());
  }
}
