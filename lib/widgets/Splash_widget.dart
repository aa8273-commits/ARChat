import 'package:chatt/widgets/waveAndloading.dart';
import 'package:flutter/material.dart';

class Splash_widget extends StatelessWidget {
  const Splash_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff08131F), Color(0xff0F2742), Color(0xff163B5F)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -120,
            left: -100,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.05),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -140,
            right: -120,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.03),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 50),
                Image.asset("assets/images/logo.png", width: 240),

                const SizedBox(height: 60),

                const Text(
                  "Chat App",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Connect with everyone, anytime.",
                  style: TextStyle(
                    color: Colors.white.withOpacity(.7),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          const Align(
            alignment: Alignment.bottomCenter,
            child: WaveAndLoading(),
          ),
        ],
      ),
    );
  }
}
