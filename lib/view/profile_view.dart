import 'package:chatt/cubit/profile_cubit.dart';
import 'package:chatt/cubit/profile_state.dart';
import 'package:chatt/view/edit_profile_view.dart';
import 'package:chatt/view/help_view.dart';
import 'package:chatt/view/login_view.dart';
import 'package:chatt/view/privacy_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const String id = "profile";

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final cubit = ProfileCubit.get(context);

          return Scaffold(
            backgroundColor: const Color(0xff08131F),
            appBar: AppBar(
              backgroundColor: const Color(0xff0F2742),
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            body: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final data = snapshot.data!.data() as Map<String, dynamic>;

                final image = data["image"] ?? "";
                final name = data["name"] ?? "";
                final email = data["email"] ?? "";
                final bio = data["bio"] ?? "";
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.white24,
                            backgroundImage: image.isNotEmpty
                                ? NetworkImage(image)
                                : null,
                            child: image.isEmpty
                                ? const Icon(
                                    Icons.person,
                                    size: 70,
                                    color: Colors.white,
                                  )
                                : null,
                          ),

                          FloatingActionButton.small(
                            heroTag: "camera",
                            backgroundColor: Colors.orangeAccent,
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: const Color(0xff0F2742),
                                builder: (_) {
                                  return SafeArea(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: const Icon(
                                            Icons.photo,
                                            color: Colors.white,
                                          ),
                                          title: const Text(
                                            "Gallery",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          onTap: () async {
                                            Navigator.pop(context);

                                            await cubit.pickFromGallery();

                                            await cubit.uploadProfileImage();
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                          ),
                                          title: const Text(
                                            "Camera",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          onTap: () async {
                                            Navigator.pop(context);

                                            await cubit.pickFromCamera();

                                            await cubit.uploadProfileImage();
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          title: const Text(
                                            "Remove Photo",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onTap: () async {
                                            Navigator.pop(context);

                                            await cubit.removeProfileImage();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Icon(Icons.camera_alt),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        email,
                        style: const TextStyle(color: Colors.white70),
                      ),

                      const SizedBox(height: 30),

                      const SizedBox(height: 15),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xff0F2742),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.orangeAccent,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "النبذة الشخصية",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              bio.isEmpty ? "لا توجد نبذة شخصية." : bio,
                              style: const TextStyle(
                                color: Colors.white70,
                                height: 1.5,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),

                      buildTile(
                        Icons.person,
                        "Edit Profile",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: ProfileCubit.get(context),
                                child: const EditProfileView(),
                              ),
                            ),
                          );
                        },
                      ),
                      buildTile(
                        Icons.lock,
                        "Privacy",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PrivacyView(),
                            ),
                          );
                        },
                      ),

                      buildTile(
                        Icons.help,
                        "Help",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const HelpView()),
                          );
                        },
                      ),

                      buildTile(
                        Icons.logout,
                        "Logout",
                        color: Colors.red,
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginView.id,
                            (route) => false,
                          );
                        },
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildTile(
    IconData icon,
    String title, {
    Color color = Colors.white,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      trailing: Icon(Icons.arrow_forward_ios, color: color, size: 16),
      onTap: onTap,
    );
  }
}
