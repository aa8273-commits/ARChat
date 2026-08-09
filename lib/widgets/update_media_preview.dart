import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class UpdateMediaPreview extends StatelessWidget {
  const UpdateMediaPreview({
    super.key,
    required this.selectedFile,
    required this.type,
    required this.videoController,
    required this.onPlayPause,
  });

  final File selectedFile;
  final String type;
  final VideoPlayerController? videoController;
  final VoidCallback onPlayPause;

  @override
  Widget build(BuildContext context) {
    if (type == "video") {
      if (videoController == null || !videoController!.value.isInitialized) {
        return const SizedBox(
          height: 200,
          child: Center(child: CircularProgressIndicator(color: Colors.orange)),
        );
      }

      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: videoController!.value.aspectRatio,
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(videoController!),

              IconButton(
                iconSize: 55,
                color: Colors.white,
                onPressed: onPlayPause,
                icon: Icon(
                  videoController!.value.isPlaying
                      ? Icons.pause_circle
                      : Icons.play_circle,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.file(
        selectedFile,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
