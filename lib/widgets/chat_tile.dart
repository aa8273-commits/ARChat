import 'package:chatt/widgets/chat_tile_avatar.dart';
import 'package:chatt/widgets/chat_tile_message_info.dart';
import 'package:chatt/widgets/chat_tile_trailing.dart';

import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.uid,
    this.image,
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
    required this.online,
    required this.onTap,
    required this.status,
    this.isGroup = false,
    this.conversationId,
  });

  final String uid;
  final String? image;
  final String name;
  final String message;
  final String time;
  final int unread;
  final bool online;
  final VoidCallback onTap;
  final String status;

  final bool isGroup;
  final String? conversationId;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        splashColor: Colors.orange.withOpacity(.15),
        highlightColor: Colors.orange.withOpacity(.05),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              ChatTileAvatar(
                isGroup: isGroup,
                conversationId: conversationId,
                uid: uid,
                image: image,
                online: online,
              ),

              const SizedBox(width: 15),

              ChatTileMessageInfo(name: name, message: message, status: status),

              const SizedBox(width: 10),

              ChatTileTrailing(time: time, unread: unread),
            ],
          ),
        ),
      ),
    );
  }
}
