import 'package:chatt/cubit/profile_cubit.dart';
import 'package:chatt/cubit/profile_state.dart';
import 'package:chatt/widgets/bio_text_field.dart';
import 'package:chatt/widgets/edit_profile_app_bar.dart';
import 'package:chatt/widgets/email_text_field.dart';
import 'package:chatt/widgets/name_text_field.dart';
import 'package:chatt/widgets/profile_image_section.dart';
import 'package:chatt/widgets/save_profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  static const String id = "edit_profile";

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();

  String image = "";

  @override
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      _loaded = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        loadUserData();
      });
    }
  }

  Future<void> loadUserData() async {
    final data = await ProfileCubit.get(context).getUserData();

    if (data != null) {
      nameController.text = data["name"] ?? "";
      emailController.text = data["email"] ?? "";
      bioController.text = data["bio"] ?? "";
      image = data["image"] ?? "";

      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }

        if (state is ProfileSuccess) {
          loadUserData();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تم حفظ التعديلات بنجاح")),
          );
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: const Color(0xff08131F),
            appBar: const EditProfileAppBar(),
            body: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                ProfileImageSection(image: image, cubit: cubit),

                const SizedBox(height: 30),

                NameTextField(nameController: nameController),

                const SizedBox(height: 20),

                EmailTextField(emailController: emailController),

                const SizedBox(height: 20),

                BioTextField(bioController: bioController),

                const SizedBox(height: 30),

                SaveProfileButton(
                  cubit: cubit,
                  state: state,
                  nameController: nameController,
                  bioController: bioController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
