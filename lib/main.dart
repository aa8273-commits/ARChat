import 'package:chatt/Services/local_notification_service.dart';
import 'package:chatt/cubit/Authgate_cubit.dart';
import 'package:chatt/cubit/ChatCubit.dart';

import 'package:chatt/cubit/login_cubit.dart';
import 'package:chatt/cubit/nofication_cubit.dart';
import 'package:chatt/cubit/privacy_cubit.dart';
import 'package:chatt/cubit/profile_cubit.dart';
import 'package:chatt/cubit/regsister_cubit.dart';

import 'package:chatt/cubit/updates_cubit.dart';
import 'package:chatt/firebase_options.dart';
import 'package:chatt/view/Notifications_View.dart';
import 'package:chatt/view/Splash_view.dart';
import 'package:chatt/view/about_view.dart';
import 'package:chatt/view/broadcast_view.dart';
import 'package:chatt/view/calls_view.dart';
import 'package:chatt/view/chat_view.dart';
import 'package:chatt/view/contacts_view.dart';
import 'package:chatt/view/create_group_view.dart';
import 'package:chatt/view/edit_profile_view.dart';
import 'package:chatt/view/home_view.dart';
import 'package:chatt/view/language_view.dart';
import 'package:chatt/view/login_view.dart';
import 'package:chatt/view/onboarding_view.dart';
import 'package:chatt/view/privacy_policy_view.dart';
import 'package:chatt/view/privacy_view.dart';
import 'package:chatt/view/profile_view.dart';
import 'package:chatt/view/register_view.dart';
import 'package:chatt/view/saved_messages_view.dart';
import 'package:chatt/view/settings_view.dart';
import 'package:chatt/view/storage_data_view.dart';
import 'package:chatt/view/updates_view.dart';
import 'package:chatt/widgets/RecentChats_Widget.dart';
import 'package:chatt/widgets/contact_support_view.dart';
import 'package:chatt/widgets/faq_view.dart';
import 'package:chatt/widgets/feedback_view.dart';
import 'package:chatt/widgets/group_info_widget.dart';
import 'package:chatt/widgets/report_bug_view.dart';
import 'package:chatt/widgets/terms_conditions_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService.init();

  await FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onMessage.listen((message) {
    final title = message.notification?.title;

    if (title == null || title.isEmpty) {
      return;
    }

    NotificationService.showNotification(
      title: title,
      body: message.notification?.body ?? "",
    );
  });

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PrivacyCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (_) => UpdateCubit()..getUpdates()),
        BlocProvider(create: (_) => NotificationCubit()),
      ],
      child: const chat_app(),
    ),
  );
}

// ignore: camel_case_types
class chat_app extends StatelessWidget {
  const chat_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        UpdatesView.id: (_) => const UpdatesView(),
        ContactsView.id: (_) => const ContactsView(),
        ProfileView.id: (_) => const ProfileView(),
        EditProfileView.id: (_) => const EditProfileView(),
        SettingsView.id: (_) => const SettingsView(),
        AboutView.id: (_) => const AboutView(),
        CallsView.id: (_) => const CallsView(),

        SavedMessagesView.id: (_) => const SavedMessagesView(),
        RegisterView.id: (context) => RegisterView(),
        SplashHomeView.id: (context) => const SplashHomeView(),
        OnboardingHomeView.id: (context) => const OnboardingHomeView(),
        LoginView.id: (context) => LoginView(),
        HomeView.id: (context) => const HomeView(),
        NotificationsView.id: (context) => const NotificationsView(),
        GroupInfoView.id: (context) => const GroupInfoView(conversationId: ''),
        PrivacyView.id: (_) => const PrivacyView(),
        FAQView.id: (context) => const FAQView(),
        ContactSupportView.id: (context) => const ContactSupportView(),
        ReportBugView.id: (context) => const ReportBugView(),
        FeedbackView.id: (context) => const FeedbackView(),
        TermsConditionsView.id: (context) => const TermsConditionsView(),
        PrivacyPolicyView.id: (context) => const PrivacyPolicyView(),
        CreateGroupView.id: (context) => const CreateGroupView(),
        StorageDataView.id: (context) => const StorageDataView(),
        LanguageView.id: (context) => const LanguageView(),
        BroadcastView.id: (context) => const BroadcastView(),
        RecentChatsWidget.id: (context) =>
            const RecentChatsWidget(searchText: ''),
        ChatView.id: (context) => ChatView(
          conversationId: '',
          receiverId: '',
          receiverName: '',
          receiverImage: '',
        ),
      },
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
  }
}

// // AliAli@gmail.com AbdoAbdo@gmail.com A123456789 woal@gmail.com ziad@gmail.com
// // Ahmed@gmail.com 
//nour@gmail.com