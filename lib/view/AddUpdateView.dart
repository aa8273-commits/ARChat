import 'dart:io';

import 'package:chatt/Services/cloudinary_service.dart';
import 'package:chatt/widgets/add_media_button.dart';
import 'package:chatt/widgets/add_update_app_bar.dart';
import 'package:chatt/widgets/update_text_field.dart';
import 'package:chatt/widgets/update_media_preview.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chatt/cubit/updates_cubit.dart';
import 'package:chatt/modols/updateModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class AddUpdateView extends StatefulWidget {
  const AddUpdateView({super.key});

  static const id = '/add_update';

  @override
  State<AddUpdateView> createState() => _AddUpdateViewState();
}

class _AddUpdateViewState extends State<AddUpdateView> {
  final TextEditingController controller = TextEditingController();

  File? selectedFile;

  String type = "text";

  VideoPlayerController? videoController;

  Future<void> pickMedia() async {
    final picker = ImagePicker();

    final file = await picker.pickMedia();

    if (file == null) return;

    final selected = File(file.path);

    final isVideo =
        file.mimeType?.startsWith("video/") == true ||
        file.path.toLowerCase().endsWith(".mp4") ||
        file.path.toLowerCase().endsWith(".mov") ||
        file.path.toLowerCase().endsWith(".avi") ||
        file.path.toLowerCase().endsWith(".mkv");

    await videoController?.dispose();
    videoController = null;

    if (isVideo) {
      final controller = VideoPlayerController.file(selected);

      await controller.initialize();

      await controller.setLooping(true);

      if (!mounted) {
        await controller.dispose();
        return;
      }

      setState(() {
        selectedFile = selected;
        type = "video";
        videoController = controller;
      });

      await controller.play();
    } else {
      setState(() {
        selectedFile = selected;
        type = "image";
      });
    }
  }

  Future<void> publishUpdate() async {
    if (controller.text.isEmpty && selectedFile == null) {
      return;
    }

    String content = controller.text;

    final String finalType = type;

    if (selectedFile != null) {
      if (type == "image") {
        content = await CloudinaryService.uploadImage(selectedFile!) ?? "";
      } else if (type == "video") {
        content = await CloudinaryService.uploadVideo(selectedFile!) ?? "";
      }
    }

    if (!mounted) return;

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final update = UpdateModel(
      id: "",
      content: content,
      type: finalType,
      text: controller.text,
      username: user.displayName ?? "User",
      userImage: user.photoURL ?? "",
      viewers: [],
      reactions: {},
      createdAt: DateTime.now(),
      userId: user.uid,
    );

    await context.read<UpdateCubit>().addUpdate(update: update);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  void dispose() {
    controller.dispose();
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff08131F),

      appBar: AddUpdateAppBar(onPost: publishUpdate),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            UpdateTextField(controller: controller),

            const SizedBox(height: 20),

            if (selectedFile != null)
              UpdateMediaPreview(
                selectedFile: selectedFile!,
                type: type,
                videoController: videoController,
                onPlayPause: () {
                  if (videoController == null) return;

                  setState(() {
                    if (videoController!.value.isPlaying) {
                      videoController!.pause();
                    } else {
                      videoController!.play();
                    }
                  });
                },
              ),

            const Spacer(),

            AddMediaButton(onTap: pickMedia),
          ],
        ),
      ),
    );
  }
}
