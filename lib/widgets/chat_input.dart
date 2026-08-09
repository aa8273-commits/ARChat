import 'dart:io';

import 'package:chatt/Services/File_Service.dart';
// import 'package:chatt/Services/Voice_Service.dart';
import 'package:chatt/Services/cloudinary_service.dart';

import 'package:chatt/cubit/ChatCubit.dart';
import 'package:chatt/cubit/ChatState.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({
    super.key,
    required this.controller,
    required this.conversationId,
    required this.receiverId,
  });

  final TextEditingController controller;
  final String conversationId;
  final String receiverId;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  bool showEmoji = false;
  // bool isRecording = false;
  Future<void> sendText() async {
    final text = widget.controller.text.trim();

    if (text.isEmpty) return;

    await context.read<ChatCubit>().sendMessage(
      conversationId: widget.conversationId,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      receiverId: widget.receiverId,
      message: text,
    );

    widget.controller.clear();
  }

  Future<void> sendImage() async {
    Navigator.pop(context); // يقفل الـ bottom sheet فقط

    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedImage == null) return;

    final imageFile = File(pickedImage.path);

    final imageUrl = await CloudinaryService.uploadImage(imageFile);

    if (imageUrl == null) return;

    await context.read<ChatCubit>().sendMessage(
      conversationId: widget.conversationId,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      receiverId: widget.receiverId,
      message: imageUrl,
      type: "image",
    );
  }

  Future<void> sendFile() async {
    final file = await FileService.pickAndUploadFile();

    if (file == null) return;

    await context.read<ChatCubit>().sendMessage(
      conversationId: widget.conversationId,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      receiverId: widget.receiverId,
      message: file["url"]!,
      type: "file",
      fileName: file["fileName"],
    );
  }

  Future<void> sendCameraImage() async {
    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (pickedImage == null) return;

    final imageFile = File(pickedImage.path);

    final imageUrl = await CloudinaryService.uploadImage(imageFile);

    if (imageUrl == null) return;

    await context.read<ChatCubit>().sendMessage(
      conversationId: widget.conversationId,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      receiverId: widget.receiverId,
      message: imageUrl,
      type: "image",
    );

    // if (mounted) Navigator.pop(context);
  }

  void showAttachments() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff0F2742),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) {
        return SizedBox(
          height: 180,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              attachmentItem(Icons.image, "صورة", sendImage),
              attachmentItem(Icons.insert_drive_file, "ملف", sendFile),
              attachmentItem(Icons.camera_alt, "كاميرا", sendCameraImage),
            ],
          ),
        );
      },
    );
  }

  Widget attachmentItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xff2B475E),
            child: Icon(icon, color: Colors.orangeAccent, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final cubit = context.read<ChatCubit>();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (cubit.replyMessage != null)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xff0F2742),
                  borderRadius: BorderRadius.circular(15),
                  border: const Border(
                    left: BorderSide(color: Colors.orangeAccent, width: 4),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<String>(
                            future: cubit.getUserName(
                              cubit.replyMessage!.senderId,
                            ),
                            builder: (context, snapshot) {
                              return Text(
                                snapshot.data ?? "User",
                                style: const TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 4),
                          Text(
                            cubit.replyMessage!.type == "image"
                                ? "📷 Photo"
                                : cubit.replyMessage!.type == "file"
                                ? "📄 File"
                                : cubit.replyMessage!.message,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: cubit.cancelReply,
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: TextField(
                controller: widget.controller,
                onChanged: (_) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: "Write a message...",
                  filled: true,
                  fillColor: Colors.white,

                  prefixIcon: IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      setState(() {
                        showEmoji = !showEmoji;
                      });
                    },
                    icon: Icon(
                      showEmoji
                          ? Icons.keyboard_alt_outlined
                          : Icons.emoji_emotions_outlined,
                      color: Colors.orangeAccent,
                    ),
                  ),

                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: showAttachments,
                        icon: const Icon(
                          Icons.attach_file,
                          color: Colors.orangeAccent,
                        ),
                      ),

                      IconButton(
                        onPressed: sendText,
                        icon: const Icon(
                          Icons.send,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ],
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ),

            if (showEmoji)
              SizedBox(
                height: 300,
                child: EmojiPicker(
                  textEditingController: widget.controller,
                  onEmojiSelected: (category, emoji) {},
                  config: Config(
                    checkPlatformCompatibility: false,

                    searchViewConfig: const SearchViewConfig(
                      backgroundColor: Color(0xff163B5F),
                      buttonIconColor: Colors.white,
                      inputTextStyle: TextStyle(color: Colors.white),
                      hintTextStyle: TextStyle(color: Colors.white70),
                    ),

                    emojiViewConfig: const EmojiViewConfig(
                      backgroundColor: Color(0xff0F2742),
                      emojiSizeMax: 28,
                    ),

                    categoryViewConfig: const CategoryViewConfig(
                      backgroundColor: Color(0xff163B5F),
                      iconColor: Colors.white54,
                      iconColorSelected: Colors.orangeAccent,
                      indicatorColor: Colors.orangeAccent,
                    ),

                    bottomActionBarConfig: const BottomActionBarConfig(
                      backgroundColor: Color(0xff163B5F),
                      buttonColor: Color(0xff163B5F),
                      buttonIconColor: Colors.white,
                    ),

                    customSearchIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),

                    customBackspaceIcon: const Icon(
                      Icons.backspace,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
