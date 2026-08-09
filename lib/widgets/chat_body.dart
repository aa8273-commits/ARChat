import 'package:chatt/modols/message.dart';
import 'package:chatt/view/chat_view.dart';
import 'package:chatt/widgets/chat_input.dart';
import 'package:chatt/widgets/messages_list.dart';
import 'package:flutter/material.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({
    super.key,
    required this.scrollController,
    required this.messages,
    required this.controller,
    required this.widget,
  });

  final ScrollController scrollController;
  final List<Message> messages;
  final TextEditingController controller;
  final ChatView widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MessageList(
            scrollController: scrollController,
            messages: messages,
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: ChatInput(
            controller: controller,
            conversationId: widget.conversationId,
            receiverId: widget.receiverId,
          ),
        ),
      ],
    );
  }
}
