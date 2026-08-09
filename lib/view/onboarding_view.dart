import 'package:chatt/widgets/CustomSmoothPageIndicator.dart';
import 'package:chatt/widgets/pageViewonboarding.dart';
import 'package:flutter/material.dart';

class OnboardingHomeView extends StatefulWidget {
  const OnboardingHomeView({super.key});
  static String id = 'OnboardingHomeView';

  @override
  State<OnboardingHomeView> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnboardingHomeView> {
  final PageController controller = PageController();

  final List<Map<String, String>> pages = [
    {
      "image": "https://cdn-icons-png.flaticon.com/512/1041/1041916.png",
      "title": "Start Chatting",
      "subtitle":
          "Connect with friends, family, and coworkers through fast and seamless messaging.",
    },
    {
      "image": "https://cdn-icons-png.flaticon.com/512/4712/4712035.png",
      "title": "Private & Secure",
      "subtitle":
          "Enjoy end-to-end encrypted conversations that keep your messages safe and private.",
    },
    {
      "image": "https://cdn-icons-png.flaticon.com/512/6463/6463383.png",
      "title": "Share Without Limits",
      "subtitle":
          "Send photos, videos, voice messages, and files instantly with just one tap.",
    },
  ];
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff08131F),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff08131F),
                  Color(0xff0F2742),
                  Color(0xff163B5F),
                ],
              ),
            ),
          ),

          Positioned(
            top: -120,
            right: -100,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(.12),
              ),
            ),
          ),

          Positioned(
            bottom: -150,
            left: -120,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyan.withOpacity(.08),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                pageViewonboarding(controller: controller, pages: pages),

                CustomSmoothPageIndicator(controller: controller, pages: pages),

                const SizedBox(height: 35),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
