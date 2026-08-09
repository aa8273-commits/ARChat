import 'dart:io';

import 'package:chatt/Services/cloudinary_service.dart';

import 'package:chatt/cubit/ChatCubit.dart';

import 'package:chatt/modols/message.dart';
import 'package:chatt/widgets/Chat_App_Bar.dart';
import 'package:chatt/widgets/chat_body.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';

class ChatView extends StatefulWidget {
  ChatView({
    super.key,
    required this.conversationId,
    required this.receiverId,
    required this.receiverName,
    required this.receiverImage,
    this.isGroup = false,
  });

  static String id = 'chatview';

  final String conversationId;
  final String receiverId;
  final String receiverName;
  final String receiverImage;
  final bool isGroup;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ImagePicker picker = ImagePicker();
  final ScrollController scrollController = ScrollController();

  final TextEditingController controller = TextEditingController();
  bool showEmoji = false;
  @override
  Future<void> sendImage() async {
    final XFile? picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (picked == null) return;

    final imageFile = File(picked.path);

    final imageUrl = await CloudinaryService.uploadImage(imageFile);

    if (imageUrl == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("فشل رفع الصورة")));
      return;
    }

    await context.read<ChatCubit>().sendMessage(
      conversationId: widget.conversationId,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      receiverId: widget.receiverId,
      message: imageUrl,
      type: "image",
    );
  }

  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      await context.read<ChatCubit>().markMessagesAsDelivered(
        conversationId: widget.conversationId,
        currentUserId: currentUserId,
      );

      if (!mounted) return;

      await context.read<ChatCubit>().markMessagesAsSeen(
        conversationId: widget.conversationId,
        currentUserId: currentUserId,
      );
    });
  }

  CollectionReference get messagesCollection => FirebaseFirestore.instance
      .collection("conversations")
      .doc(widget.conversationId)
      .collection("messages");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messagesCollection
          .orderBy("createdAt", descending: true)
          .snapshots(),

      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        List<Message> messages = [];

        for (var doc in snapshot.data!.docs) {
          messages.add(Message.fromJson(doc.data() as Map<String, dynamic>));
        }

        return Scaffold(
          backgroundColor: const Color(0xff071521),

          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: ChatAppBar(
              receiverId: widget.receiverId,
              conversationId: widget.conversationId,
              isGroup: widget.isGroup,
            ),
          ),
          body: ChatBody(
            scrollController: scrollController,
            messages: messages,
            controller: controller,
            widget: widget,
          ),
        );
      },
    );
  }
}
