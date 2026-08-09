import 'package:chatt/widgets/message_item.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  const MessageList({
    super.key,
    required this.scrollController,
    required this.messages,
  });

  final ScrollController scrollController;
  final messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,

      controller: scrollController,

      itemCount: messages.length,

      itemBuilder: (context, index) {
        final message = messages[index];

        final isMe = message.senderId == FirebaseAuth.instance.currentUser!.uid;

        return MessageItem(message: message, isMe: isMe);
      },
    );
  }
}
