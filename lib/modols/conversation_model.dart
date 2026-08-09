import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel {
  final String id;
  final String lastMessage;
  final Timestamp? lastTime;
  final String lastSenderId;
  final String lastStatus;
  final Map<String, dynamic> members;

  ConversationModel({
    required this.id,
    required this.lastMessage,
    required this.lastTime,
    required this.lastSenderId,
    required this.lastStatus,
    required this.members,
  });

  factory ConversationModel.fromJson(
    Map<String, dynamic> json,
    String documentId,
  ) {
    return ConversationModel(
      id: documentId,
      lastMessage: json['lastMessage'] ?? '',
      lastTime: json['lastTime'],
      lastSenderId: json['lastSenderId'] ?? '',
      lastStatus: json['lastStatus'] ?? 'sent',
      members: Map<String, dynamic>.from(json['members'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lastMessage": lastMessage,
      "lastTime": lastTime,
      "lastSenderId": lastSenderId,
      "lastStatus": lastStatus,
      "members": members,
    };
  }
}
