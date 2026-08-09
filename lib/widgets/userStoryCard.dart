import 'package:chatt/cubit/updates_cubit.dart';
import 'package:chatt/view/UpdateViewerView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;

Widget userStoryCard(
  BuildContext context,
  List<dynamic> userStories,
  String myId,
) {
  final firstStory = userStories.first;

  final bool allSeen = userStories.every(
    (story) => story.viewers.contains(myId),
  );

  return GestureDetector(
    onTap: () {
      for (final story in userStories) {
        if (!story.viewers.contains(myId)) {
          context.read<UpdateCubit>().seenUpdate(
            updateId: story.id,
            userId: myId,
          );
        }
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              UpdateViewerView(updates: userStories, initialIndex: 0),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.08),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withOpacity(.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: allSeen ? Colors.grey : Colors.orangeAccent,
                width: 3,
              ),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: firstStory.userImage.isNotEmpty
                  ? NetworkImage(firstStory.userImage)
                  : null,
              child: firstStory.userImage.isEmpty
                  ? const Icon(Icons.person)
                  : null,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  firstStory.username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "${userStories.length} حالة",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          Icon(Icons.arrow_forward_ios, color: Colors.orangeAccent, size: 18),
        ],
      ),
    ),
  );
}
