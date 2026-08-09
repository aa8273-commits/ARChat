import 'package:chatt/widgets/message_status_icon.dart';
import 'package:flutter/material.dart';

class ChatTileMessageInfo extends StatelessWidget {
  const ChatTileMessageInfo({
    super.key,
    required this.name,
    required this.message,
    required this.status,
  });

  final String name;
  final String message;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: .3,
            ),
          ),

          const SizedBox(height: 6),

          Row(
            children: [
              Expanded(
                child: Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),

              if (status.isNotEmpty) MessageStatusIcon(status: status),
            ],
          ),
        ],
      ),
    );
  }
}
