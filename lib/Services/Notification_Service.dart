import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> sendNotification({
    required String receiverId,
    required String senderId,
    required String message,
  }) async {
    await firestore
        .collection("notifications")
        .doc(receiverId)
        .collection("items")
        .add({
          "title": "New message",

          "body": message,

          "senderId": senderId,

          "createdAt": FieldValue.serverTimestamp(),

          "seen": false,
        });
  }
}
