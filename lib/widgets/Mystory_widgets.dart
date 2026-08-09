import 'package:chatt/view/AddUpdateView.dart';
import 'package:flutter/material.dart';

class Mystory extends StatelessWidget {
  const Mystory({super.key, required this.orange, required this.context});

  final Color orange;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,

          MaterialPageRoute(builder: (_) => const AddUpdateView()),
        );
      },

      child: Container(
        width: 85,

        margin: const EdgeInsets.only(right: 15),

        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(3),

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                border: Border.all(color: orange, width: 3),
              ),

              child: CircleAvatar(
                radius: 34,

                backgroundColor: const Color(0xff163B5F),

                child: Icon(Icons.add, color: orange, size: 35),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "حالتي",

              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
