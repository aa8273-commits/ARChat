import 'package:chatt/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';

class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({
    super.key,
    required this.image,
    required this.cubit,
  });

  final String image;
  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white24,
            backgroundImage: image.isNotEmpty ? NetworkImage(image) : null,
            child: image.isEmpty
                ? const Icon(Icons.person, size: 60, color: Colors.white)
                : null,
          ),

          FloatingActionButton.small(
            heroTag: "editImage",
            backgroundColor: Colors.orangeAccent,
            child: const Icon(Icons.camera_alt),
            onPressed: () => showModalBottomSheet(
              context: context,
              backgroundColor: const Color(0xff0F2742),
              builder: (_) {
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.photo, color: Colors.white),
                        title: const Text(
                          "المعرض",
                          style: TextStyle(color: Colors.white),
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
                          "الكاميرا",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () async {
                          Navigator.pop(context);
                          await cubit.pickFromCamera();
                          await cubit.uploadProfileImage();
                        },
                      ),

                      ListTile(
                        leading: const Icon(Icons.delete, color: Colors.red),
                        title: const Text(
                          "حذف الصورة",
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
            ),
          ),
        ],
      ),
    );
  }
}
