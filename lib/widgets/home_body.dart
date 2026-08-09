import 'package:flutter/material.dart';

class homeBody extends StatelessWidget {
  const homeBody({super.key, required this.pages, required this.currentIndex});

  final List<Widget> pages;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff08131F), Color(0xff0F2742), Color(0xff163B5F)],
            ),
          ),
        ),

        Positioned(
          top: -120,
          right: -120,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.08),
              shape: BoxShape.circle,
            ),
          ),
        ),

        Positioned(
          bottom: -150,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.cyan.withOpacity(.05),
              shape: BoxShape.circle,
            ),
          ),
        ),

        pages[currentIndex],
      ],
    );
  }
}
