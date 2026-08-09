import 'package:chatt/cubit/UpdateState.dart';
import 'package:chatt/cubit/updates_cubit.dart';
import 'package:chatt/widgets/Mystory_widgets.dart';
import 'package:chatt/view/UpdateViewerView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdatesWidget extends StatelessWidget {
  const UpdatesWidget({super.key});

  final Color orange = const Color(0xffff8c00);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateCubit, UpdateState>(
      builder: (context, state) {
        if (state is UpdateLoading) {
          return const SizedBox(
            height: 125,
            child: Center(
              child: CircularProgressIndicator(color: Colors.orangeAccent),
            ),
          );
        }

        if (state is! UpdateLoaded) {
          return SizedBox(
            height: 125,
            child: Mystory(orange: orange, context: context),
          );
        }

        final updates = state.updates;

        final myId = FirebaseAuth.instance.currentUser!.uid;

        final Map<String, List<dynamic>> storiesByUser = {};

        for (final update in updates) {
          final userId = update.userId.toString();

          storiesByUser.putIfAbsent(userId, () => []);

          storiesByUser[userId]!.add(update);
        }

        final users = storiesByUser.keys.toList();

        return SizedBox(
          height: 125,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            itemCount: users.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Mystory(orange: orange, context: context);
              }

              final userId = users[index - 1];

              final userUpdates = storiesByUser[userId]!;

              final firstUpdate = userUpdates.first;
              final allSeen = userUpdates.every(
                (update) => update.viewers.contains(myId),
              );

              return GestureDetector(
                onTap: () {
                  for (final update in userUpdates) {
                    if (!update.viewers.contains(myId)) {
                      context.read<UpdateCubit>().seenUpdate(
                        updateId: update.id,
                        userId: myId,
                      );
                    }
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UpdateViewerView(
                        updates: userUpdates,
                        initialIndex: 0,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 85,
                  margin: const EdgeInsets.only(right: 15),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: allSeen ? Colors.grey : orange,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 34,
                          backgroundImage: firstUpdate.userImage.isNotEmpty
                              ? NetworkImage(firstUpdate.userImage)
                              : null,
                          child: firstUpdate.userImage.isEmpty
                              ? const Icon(Icons.person, size: 30)
                              : null,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        firstUpdate.username,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
