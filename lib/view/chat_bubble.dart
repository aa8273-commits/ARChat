import 'package:chatt/modols/message.dart';
import 'package:chatt/widgets/ChatBubbleWidget.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final Message message;
  void _showMessageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff0F2742),
      builder: (context) {
        return ListTile(
          leading: const Icon(Icons.bookmark, color: Colors.orangeAccent),
          title: const Text(
            "Save Message",
            style: TextStyle(color: Colors.white),
          ),
          onTap: () async {
            final uid = FirebaseAuth.instance.currentUser!.uid;

            await FirebaseFirestore.instance
                .collection("users")
                .doc(uid)
                .collection("savedMessages")
                .add({
                  "text": message.message,
                  "type": message.type,
                  "senderId": message.senderId,
                  "createdAt": FieldValue.serverTimestamp(),
                });

            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onLongPress: () {
          _showMessageOptions(context);
        },
        child: ChatBubbleWidget(message: message),
      ),
    );
  }
}
