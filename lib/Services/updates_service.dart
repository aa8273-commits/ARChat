import 'dart:io';

import 'package:chatt/modols/updateModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file, String type) async {
    try {
      final path = "updates/${DateTime.now().millisecondsSinceEpoch}";

      final ref = _storage.ref().child(path);

      print("Uploading: ${file.path}");

      await ref.putFile(file);

      print("Uploaded");

      final url = await ref.getDownloadURL();

      print(url);

      return url;
    } catch (e) {
      print("UPLOAD ERROR: $e");
      rethrow;
    }
  }

  Future<void> addUpdate({required UpdateModel update}) async {
    await _firestore.collection("updates").add(update.toJson());
  }

  Stream<List<UpdateModel>> getUpdates() {
    return _firestore
        .collection("updates")
        .where(
          "createdAt",

          isGreaterThan: Timestamp.fromDate(
            DateTime.now().subtract(const Duration(hours: 24)),
          ),
        )
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => UpdateModel.fromJson(doc)).toList();
        });
  }

  Future<void> addViewer({
    required String updateId,

    required String userId,
  }) async {
    await _firestore.collection("updates").doc(updateId).update({
      "viewers": FieldValue.arrayUnion([userId]),
    });
  }
}
