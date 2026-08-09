import 'package:flutter/material.dart';

class ChatTileTrailing extends StatelessWidget {
  const ChatTileTrailing({super.key, required this.time, required this.unread});

  final String time;
  final int unread;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          time,
          style: const TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 8),

        unread == 0
            ? const SizedBox(height: 24)
            : Container(
                height: 24,
                width: 24,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  unread.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
      ],
    );
  }
}
