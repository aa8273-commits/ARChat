import 'package:chatt/cubit/UpdateState.dart';
import 'package:chatt/cubit/updates_cubit.dart';

import 'package:chatt/view/UpdateViewerView.dart';
import 'package:chatt/widgets/_myStory.dart';
import 'package:chatt/widgets/emptyState.dart';
import 'package:chatt/widgets/userStoryCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdatesView extends StatelessWidget {
  const UpdatesView({super.key});

  static const id = '/updates';

  final Color orange = const Color(0xffff8c00);
  final Color background = const Color(0xff08131F);
  final Color card = const Color(0xff0F2742);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff08131F), Color(0xff0F2742), Color(0xff163B5F)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<UpdateCubit, UpdateState>(
            builder: (context, state) {
              if (state is UpdateLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.orangeAccent),
                );
              }

              if (state is UpdateFailure) {
                return Center(
                  child: Text(
                    state.error,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }

              if (state is UpdateLoaded) {
                final updates = state.updates;

                final user = FirebaseAuth.instance.currentUser;

                if (user == null) {
                  return const Center(
                    child: Text(
                      "يجب تسجيل الدخول",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final myId = user.uid;

                final Map<String, List<dynamic>> groupedUpdates = {};

                for (final update in updates) {
                  if (!groupedUpdates.containsKey(update.userId)) {
                    groupedUpdates[update.userId] = [];
                  }

                  groupedUpdates[update.userId]!.add(update);
                }

                final usersWithStories = groupedUpdates.entries.toList();

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "الحالات",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            const Text(
                              "شارك لحظاتك مع أصدقائك",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 20),

                            SizedBox(
                              height: 125,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,

                                itemCount: usersWithStories.length + 1,

                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return myStory(context);
                                  }

                                  final userStories =
                                      usersWithStories[index - 1].value;

                                  if (userStories.isEmpty) {
                                    return const SizedBox();
                                  }

                                  final firstStory = userStories.first;

                                  final bool allSeen = userStories.every(
                                    (story) => story.viewers.contains(myId),
                                  );

                                  return GestureDetector(
                                    onTap: () {
                                      for (final story in userStories) {
                                        if (!story.viewers.contains(myId)) {
                                          context
                                              .read<UpdateCubit>()
                                              .seenUpdate(
                                                updateId: story.id,
                                                userId: myId,
                                              );
                                        }
                                      }

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => UpdateViewerView(
                                            updates: userStories,
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
                                                color: allSeen
                                                    ? Colors.grey
                                                    : orange,
                                                width: 3,
                                              ),
                                            ),
                                            child: CircleAvatar(
                                              radius: 34,
                                              backgroundImage:
                                                  firstStory
                                                      .userImage
                                                      .isNotEmpty
                                                  ? NetworkImage(
                                                      firstStory.userImage,
                                                    )
                                                  : null,
                                              child:
                                                  firstStory.userImage.isEmpty
                                                  ? const Icon(
                                                      Icons.person,
                                                      size: 30,
                                                      color: Colors.white,
                                                    )
                                                  : null,
                                            ),
                                          ),

                                          const SizedBox(height: 8),

                                          Text(
                                            firstStory.username,
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
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "آخر التحديثات",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 15),

                            if (updates.isEmpty)
                              emptyState()
                            else
                              ...usersWithStories.map((entry) {
                                final userStories = entry.value;

                                return userStoryCard(
                                  context,
                                  userStories,
                                  myId,
                                );
                              }),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

              return const Center(
                child: Text(
                  "لا توجد بيانات",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
