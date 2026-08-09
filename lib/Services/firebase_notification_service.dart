import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    print("Notification Service Started");

    await messaging.requestPermission();

    String? token = await messaging.getToken();
    print("FCM TOKEN: $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notification received:");
      print(message.notification?.title);
      print(message.notification?.body);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification opened");
    });
  }
}
