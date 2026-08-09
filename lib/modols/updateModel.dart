import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateModel {
  final String id;
  final String userId;
  final String username;
  final String userImage;

  final String type;
  final String content;

  final String text;

  final DateTime createdAt;

  final List<String> viewers;

  final Map<String, dynamic> reactions;

  UpdateModel({
    required this.id,
    required this.userId,
    required this.username,
    required this.userImage,
    required this.type,
    required this.content,
    required this.text,
    required this.createdAt,
    required this.viewers,
    required this.reactions,
  });

  factory UpdateModel.fromJson(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};

    return UpdateModel(
      id: doc.id,

      userId: data['userId'] ?? "",

      username: data['username'] ?? "User",

      userImage: data['userImage'] ?? "",

      type: data['type'] ?? "text",

      content: data['content'] ?? "",

      text: data['text'] ?? "",

      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),

      viewers: List<String>.from(data['viewers'] ?? []),

      reactions: Map<String, dynamic>.from(data['reactions'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,

      "username": username,

      "userImage": userImage,

      "type": type,

      "content": content,

      "text": text,

      "createdAt": Timestamp.fromDate(createdAt),

      "viewers": viewers,

      "reactions": reactions,
    };
  }
}
