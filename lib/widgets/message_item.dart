import 'package:chatt/cubit/ChatCubit.dart';
import 'package:chatt/view/chat_bubble.dart';
import 'package:chatt/view/chat_bubble_friend.dart';
import 'package:chatt/widgets/swipe_reply_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.message, required this.isMe});

  final dynamic message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        context.read<ChatCubit>().setReplyMessage(message);
      },

      child: SwipeReplyWrapper(
        message: message,

        child: isMe
            ? ChatBubble(message: message)
            : ChatBubbleFriend(message: message),
      ),
    );
  }
}
