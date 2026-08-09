import 'package:chatt/cubit/notification_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> notificationStream(String uid) {
    return firestore.collection("users").doc(uid).snapshots();
  }

  Future<void> resetNotifications(String uid) async {
    try {
      await firestore.collection("users").doc(uid).update({
        "notificationCount": 0,
      });

      emit(NotificationSuccess(0));
    } catch (e) {
      emit(NotificationFailure(e.toString()));
    }
  }
}
