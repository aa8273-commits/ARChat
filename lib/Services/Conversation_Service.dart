import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createOrGetConversation(
    String currentUserId,
    String receiverId,
  ) async {
    final snapshot = await _firestore.collection('conversations').get();

    for (var doc in snapshot.docs) {
      final members = Map<String, dynamic>.from(doc['members']);

      if (members.containsKey(currentUserId) &&
          members.containsKey(receiverId)) {
        return doc.id;
      }
    }

    final conversation = await _firestore.collection('conversations').add({
      "members": {currentUserId: true, receiverId: true},

      "lastMessage": "",

      "lastSenderId": "",

      "lastTime": FieldValue.serverTimestamp(),
    });

    return conversation.id;
  }

  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String receiverId,
    required String message,
    required String senderName,
    String type = "text",
    String? fileName,

    String? replyMessage,
    String? replySender,
    String? replySenderName,
    String? replyType,
  }) async {
    final messageRef = await _firestore
        .collection("conversations")
        .doc(conversationId)
        .collection("messages")
        .add({
          "senderId": senderId,
          "senderName": senderName,
          "receiverId": receiverId,
          "message": message,
          "type": type,
          "createdAt": FieldValue.serverTimestamp(),
          "status": "sent",
          "fileName": fileName,

          // Reply Data
          "replyMessage": replyMessage,
          "replySender": replySender,
          "replySenderName": replySenderName,
          "replyType": replyType,
        });

    await _firestore.collection("conversations").doc(conversationId).update({
      "lastMessage": switch (type) {
        "image" => "📷 صورة",
        "file" => "📄 ملف",
        _ => message,
      },
      "lastSenderId": senderId,
      "lastTime": FieldValue.serverTimestamp(),
      "lastMessageId": messageRef.id,
    });
  }

  Future<void> markMessagesAsDelivered({
    required String conversationId,
    required String currentUserId,
  }) async {
    final snapshot = await _firestore
        .collection("conversations")
        .doc(conversationId)
        .collection("messages")
        .where("receiverId", isEqualTo: currentUserId)
        .where("status", isEqualTo: "sent")
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.update({"status": "delivered"});
    }
  }

  Future<void> markMessagesAsSeen({
    required String conversationId,
    required String currentUserId,
  }) async {
    final snapshot = await _firestore
        .collection("conversations")
        .doc(conversationId)
        .collection("messages")
        .where("receiverId", isEqualTo: currentUserId)
        .where("status", isEqualTo: "delivered")
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.update({"status": "seen"});
    }
  }
}
