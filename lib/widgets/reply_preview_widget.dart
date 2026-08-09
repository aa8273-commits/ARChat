import 'package:chatt/cubit/ChatCubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReplyPreviewWidget extends StatelessWidget {
  const ReplyPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ChatCubit>();

    if (cubit.replyMessage == null) {
      return const SizedBox();
    }

    final message = cubit.replyMessage!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff0F2742),
        borderRadius: BorderRadius.circular(14),
        border: const Border(
          left: BorderSide(color: Colors.orangeAccent, width: 5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.senderId == FirebaseAuth.instance.currentUser!.uid
                      ? "You"
                      : (message.replySenderName ?? "User"),
                  style: const TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  message.type == "image"
                      ? "📷 Photo"
                      : message.type == "file"
                      ? "📄 File"
                      : message.type == "voice"
                      ? "🎤 Voice message"
                      : message.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: cubit.cancelReply,
            icon: const Icon(Icons.close, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
