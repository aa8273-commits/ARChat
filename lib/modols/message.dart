import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String senderId;
  final Timestamp createdAt;
  final String status;
  final String type;
  final String? fileName;

  // Reply Data
  final String? replyMessage;
  final String? replySender;
  final String? replySenderName;
  final String? replyType;
  final String? senderName;
  Message({
    required this.message,
    required this.senderId,
    required this.createdAt,
    required this.status,
    required this.type,
    this.fileName,
    this.replyMessage,
    this.replySender,
    this.replySenderName,
    this.replyType,
    this.senderName,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'] ?? '',
      senderId: json['senderId'] ?? '',
      createdAt: json['createdAt'] ?? Timestamp.now(),
      status: json['status'] ?? 'sent',
      type: json['type'] ?? 'text',

      fileName: json['fileName'],

      replyMessage: json['replyMessage'],
      replySender: json['replySender'],
      replySenderName: json['replySenderName'],
      replyType: json['replyType'],
      senderName: json['senderName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "senderId": senderId,
      "senderName": senderName,
      "createdAt": createdAt,
      "status": status,
      "type": type,

      "fileName": fileName,

      "replyMessage": replyMessage,
      "replySender": replySender,
      "replySenderName": replySenderName,
      "replyType": replyType,
    };
  }
}
