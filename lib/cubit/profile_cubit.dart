import 'dart:io';
import 'package:chatt/Services/cloudinary_service.dart';
import 'package:chatt/cubit/profile_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  final ImagePicker picker = ImagePicker();

  File? image;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final uid = auth.currentUser!.uid;

      final doc = await firestore.collection("users").doc(uid).get();

      if (doc.exists) {
        return doc.data();
      }

      return null;
    } catch (e) {
      emit(ProfileError(e.toString()));
      return null;
    }
  }

  Future<void> updateProfile({
    required String name,
    required String bio,
  }) async {
    emit(ProfileLoading());

    try {
      final uid = auth.currentUser!.uid;

      await firestore.collection("users").doc(uid).update({
        "name": name,
        "bio": bio,
      });

      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> pickFromGallery() async {
    try {
      final XFile? pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedImage == null) return;

      image = File(pickedImage.path);

      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> pickFromCamera() async {
    try {
      final XFile? pickedImage = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (pickedImage == null) return;

      image = File(pickedImage.path);

      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> uploadProfileImage() async {
    if (image == null) return;

    emit(ProfileLoading());

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      final imageUrl = await CloudinaryService.uploadImage(image!);

      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "image": imageUrl,
      });

      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> removeProfileImage() async {
    emit(ProfileLoading());

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "image": "",
      });

      image = null;

      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
