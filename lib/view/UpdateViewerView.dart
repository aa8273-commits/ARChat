import 'package:chatt/widgets/StoryRepliesView.dart';
import 'package:chatt/cubit/updates_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class UpdateViewerView extends StatefulWidget {
  final List updates;
  final int initialIndex;

  const UpdateViewerView({
    super.key,
    required this.updates,
    this.initialIndex = 0,
  });

  @override
  State<UpdateViewerView> createState() => _UpdateViewerViewState();
}

class _UpdateViewerViewState extends State<UpdateViewerView> {
  late PageController pageController;
  late int currentIndex;

  bool showEmoji = false;
  bool sending = false;

  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  final TextEditingController replyController = TextEditingController();

  dynamic get currentUpdate {
    return widget.updates[currentIndex];
  }

  final Map<String, bool> likedStories = {};

  bool get isLiked {
    return likedStories[currentUpdate.id] ?? false;
  }

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;

    pageController = PageController(initialPage: widget.initialIndex);

    for (final update in widget.updates) {
      final reactions = Map<String, dynamic>.from(update.reactions);

      likedStories[update.id] = reactions.containsKey(currentUserId);
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    replyController.dispose();
    super.dispose();
  }

  Future<void> toggleReaction() async {
    final update = currentUpdate;

    final bool oldLiked = likedStories[update.id] ?? false;

    setState(() {
      likedStories[update.id] = !oldLiked;
    });

    try {
      if (oldLiked) {
        await FirebaseFirestore.instance
            .collection("updates")
            .doc(update.id)
            .update({"reactions.$currentUserId": FieldValue.delete()});
      } else {
        await FirebaseFirestore.instance
            .collection("updates")
            .doc(update.id)
            .update({"reactions.$currentUserId": "❤️"});
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          likedStories[update.id] = oldLiked;
        });
      }

      debugPrint("Reaction Error: $e");
    }
  }

  Future<void> sendReply() async {
    if (replyController.text.trim().isEmpty || sending) {
      return;
    }

    setState(() {
      sending = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser!;

      final message = replyController.text.trim();

      await FirebaseFirestore.instance
          .collection("updates")
          .doc(currentUpdate.id)
          .collection("replies")
          .add({
            "senderId": user.uid,
            "senderName": user.displayName ?? "User",
            "senderImage": user.photoURL ?? "",
            "message": message,
            "createdAt": FieldValue.serverTimestamp(),
          });

      replyController.clear();
    } catch (e) {
      debugPrint("Reply Error: $e");
    }

    if (mounted) {
      setState(() {
        sending = false;
      });
    }
  }

  Future<void> markCurrentAsSeen() async {
    final update = currentUpdate;

    try {
      await context.read<UpdateCubit>().seenUpdate(
        updateId: update.id,
        userId: currentUserId,
      );
    } catch (e) {
      debugPrint("Seen Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final update = currentUpdate;

    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: widget.updates.length,

            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
                showEmoji = false;
              });

              markCurrentAsSeen();
            },

            itemBuilder: (context, index) {
              final item = widget.updates[index];

              return _buildStory(item);
            },
          ),

          Positioned(
            top: 35,
            left: 10,
            right: 10,
            child: Row(
              children: List.generate(widget.updates.length, (index) {
                return Expanded(
                  child: Container(
                    height: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: index <= currentIndex
                          ? Colors.white
                          : Colors.white38,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }),
            ),
          ),

          Positioned(
            top: 50,
            left: 20,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: update.userImage.isNotEmpty
                      ? NetworkImage(update.userImage)
                      : null,
                  child: update.userImage.isEmpty
                      ? const Icon(Icons.person)
                      : null,
                ),

                const SizedBox(width: 10),

                Text(
                  update.username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 50,
            right: 60,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StoryRepliesView(updateId: update.id),
                  ),
                );
              },
              icon: const Icon(Icons.chat, color: Colors.white, size: 30),
            ),
          ),

          Positioned(
            top: 50,
            right: 15,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close, color: Colors.white, size: 35),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.15),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: replyController,

                            onSubmitted: (_) {
                              sendReply();
                            },

                            style: const TextStyle(color: Colors.white),

                            decoration: const InputDecoration(
                              hintText: "Reply...",
                              hintStyle: TextStyle(color: Colors.white70),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showEmoji = !showEmoji;
                            });
                          },
                          child: const Icon(
                            Icons.emoji_emotions_outlined,
                            color: Colors.white70,
                            size: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                GestureDetector(
                  onTap: toggleReaction,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      size: 22,
                      color: isLiked ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (showEmoji)
            Positioned(
              bottom: 90,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 300,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    setState(() {
                      replyController.text += emoji.emoji;
                    });
                  },

                  config: const Config(
                    checkPlatformCompatibility: false,

                    searchViewConfig: SearchViewConfig(
                      backgroundColor: Color(0xff163B5F),
                      buttonIconColor: Colors.white,
                      inputTextStyle: TextStyle(color: Colors.white),
                      hintTextStyle: TextStyle(color: Colors.white70),
                    ),

                    emojiViewConfig: EmojiViewConfig(
                      backgroundColor: Color(0xff0F2742),
                      emojiSizeMax: 28,
                    ),

                    categoryViewConfig: CategoryViewConfig(
                      backgroundColor: Color(0xff163B5F),
                      iconColor: Colors.white54,
                      iconColorSelected: Colors.orangeAccent,
                      indicatorColor: Colors.orangeAccent,
                    ),

                    bottomActionBarConfig: BottomActionBarConfig(
                      backgroundColor: Color(0xff163B5F),
                      buttonColor: Color(0xff163B5F),
                      buttonIconColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStory(dynamic update) {
    if (update.type == "image") {
      return Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(
              update.content,
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,

              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }

                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              },

              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.white,
                    size: 60,
                  ),
                );
              },
            ),

            if (update.text != null && update.text.toString().isNotEmpty)
              Positioned(
                bottom: 120,
                left: 20,
                right: 20,
                child: Text(
                  update.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                  ),
                ),
              ),
          ],
        ),
      );
    }

    if (update.type == "text") {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Text(
            update.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    if (update.type == "video") {
      return _VideoStory(url: update.content, text: update.text);
    }

    return const Center(
      child: Text(
        "نوع الحالة غير معروف",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}

class _VideoStory extends StatefulWidget {
  final String url;
  final String text;

  const _VideoStory({required this.url, required this.text});

  @override
  State<_VideoStory> createState() => _VideoStoryState();
}

class _VideoStoryState extends State<_VideoStory> {
  late VideoPlayerController controller;

  bool initialized = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      if (widget.url.isEmpty) {
        setState(() {
          hasError = true;
        });
        return;
      }

      debugPrint("VIDEO URL:");
      debugPrint(widget.url);

      controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));

      await controller.initialize();

      await controller.setLooping(true);

      await controller.play();

      if (mounted) {
        setState(() {
          initialized = true;
        });
      }
    } catch (e) {
      debugPrint("VIDEO ERROR: $e");

      if (mounted) {
        setState(() {
          hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    if (initialized) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.white, size: 60),
            SizedBox(height: 15),
            Text(
              "تعذر تشغيل الفيديو",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      );
    }

    if (!initialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.orangeAccent),
      );
    }

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: controller.value.size.width,
                height: controller.value.size.height,
                child: VideoPlayer(controller),
              ),
            ),
          ),

          // Text over video
          if (widget.text.isNotEmpty)
            Positioned(
              bottom: 120,
              left: 20,
              right: 20,
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                ),
              ),
            ),

          // Play / Pause
          GestureDetector(
            onTap: () {
              setState(() {
                if (controller.value.isPlaying) {
                  controller.pause();
                } else {
                  controller.play();
                }
              });
            },
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.35),
                shape: BoxShape.circle,
              ),
              child: Icon(
                controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
