import 'package:flutter/material.dart';

class MessageStatusIcon extends StatelessWidget {
  const MessageStatusIcon({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case "sent":
        return const Icon(Icons.done, size: 17, color: Colors.white70);

      case "delivered":
        return const Icon(Icons.done_all, size: 17, color: Colors.white70);

      case "seen":
        return const Icon(Icons.done_all, size: 17, color: Colors.blue);

      default:
        return const SizedBox();
    }
  }
}
