import 'package:chatt/Services/Conversation_Service.dart';
import 'package:chatt/Services/Notification_Service.dart';
import 'package:chatt/cubit/ChatState.dart';
import 'package:chatt/modols/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  Message? replyMessage;

  final ConversationService _service = ConversationService();
  final NotificationService _notificationService = NotificationService();

  Future<String> getCurrentUserName() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    return doc.data()?["name"] ?? "User";
  }

  Future<String> getUserName(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    return doc.data()?["name"] ?? "User";
  }

  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String receiverId,
    required String message,
    String type = "text",
    String? fileName,
  }) async {
    emit(ChatLoading());

    try {
      final senderName = await getCurrentUserName();

      await _service.sendMessage(
        senderName: senderName,
        conversationId: conversationId,
        senderId: senderId,
        receiverId: receiverId,
        message: message,
        type: type,
        fileName: fileName,

        // Reply Data
        replyMessage: replyMessage?.message,
        replySender: replyMessage?.senderId,
        replySenderName: replyMessage?.senderName,
        replyType: replyMessage?.type,
      );

      await _notificationService.sendNotification(
        receiverId: receiverId,
        senderId: senderId,
        message: type == "image"
            ? "📷 صورة"
            : type == "file"
            ? "📎 ملف"
            : message,
      );

      cancelReply();

      emit(ChatSuccess());
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }

  void startReply(Message message) {
    replyMessage = message;
    emit(ChatReplyState());
  }

  void setReplyMessage(Message message) {
    replyMessage = message;
    emit(ChatReplyState());
  }

  void cancelReply() {
    replyMessage = null;
    emit(ChatReplyState());
  }

  Future<void> markMessagesAsDelivered({
    required String conversationId,
    required String currentUserId,
  }) async {
    try {
      await _service.markMessagesAsDelivered(
        conversationId: conversationId,
        currentUserId: currentUserId,
      );

      emit(ChatSuccess());
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }

  Future<void> markMessagesAsSeen({
    required String conversationId,
    required String currentUserId,
  }) async {
    try {
      await _service.markMessagesAsSeen(
        conversationId: conversationId,
        currentUserId: currentUserId,
      );

      emit(ChatSuccess());
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }
}
