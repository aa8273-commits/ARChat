import 'package:chatt/widgets/WaveClipper.dart';
import 'package:flutter/material.dart';

class WaveAndLoading extends StatelessWidget {
  const WaveAndLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,

      child: ClipPath(
        clipper: WaveClipper(),
        child: Container(
          height: 140,
          width: double.infinity,
          color: const Color(0xFF0D1B2A),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Loading...", style: TextStyle(color: Colors.white)),

              SizedBox(height: 10),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white24,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
