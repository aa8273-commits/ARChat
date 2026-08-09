import 'package:chatt/cubit/profile_cubit.dart';
import 'package:chatt/cubit/profile_state.dart';
import 'package:flutter/material.dart';

class SaveProfileButton extends StatelessWidget {
  const SaveProfileButton({
    super.key,
    required this.cubit,
    required this.nameController,
    required this.bioController,
    required this.state,
  });

  final ProfileCubit cubit;
  final ProfileState state;
  final TextEditingController nameController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () async {
          await cubit.updateProfile(
            name: nameController.text.trim(),
            bio: bioController.text.trim(),
          );
        },
        child: state is ProfileLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "حفظ التعديلات",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
      ),
    );
  }
}
