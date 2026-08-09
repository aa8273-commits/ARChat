import 'package:chatt/view/Notifications_View.dart';
import 'package:chatt/view/about_view.dart';
import 'package:chatt/view/broadcast_view.dart';

import 'package:chatt/view/language_view.dart';
import 'package:chatt/view/privacy_view.dart';
import 'package:chatt/view/storage_data_view.dart';
import 'package:chatt/widgets/RecentChats_Widget.dart';
import 'package:chatt/widgets/settingTile.dart';

import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const id = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff08131F),

      appBar: AppBar(
        backgroundColor: const Color(0xff08131F),
        elevation: 0,
        title: const Text("الإعدادات", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          settingTile(
            icon: Icons.lock_outline,
            title: "الخصوصية",
            subtitle: "آخر ظهور والحظر وإعدادات الخصوصية",
            onTap: () {
              Navigator.pushNamed(context, PrivacyView.id);
            },
          ),

          settingTile(
            icon: Icons.chat_outlined,
            title: "الدردشات",
            subtitle: "الخلفية وحجم الخط وإعدادات المحادثات",
            onTap: () {
              Navigator.pushNamed(context, RecentChatsWidget.id);
            },
          ),

          settingTile(
            icon: Icons.notifications_none,
            title: "الإشعارات",
            subtitle: "إشعارات الرسائل والمكالمات",
            onTap: () {
              Navigator.pushNamed(context, NotificationsView.id);
            },
          ),

          settingTile(
            icon: Icons.campaign_outlined,
            title: "البث",
            subtitle: "إدارة قنوات وبث الرسائل",
            onTap: () {
              Navigator.pushNamed(context, BroadcastView.id);
            },
          ),

          settingTile(
            icon: Icons.storage_outlined,
            title: "التخزين والبيانات",
            subtitle: "استخدام التخزين والتحميل التلقائي",
            onTap: () {
              Navigator.pushNamed(context, StorageDataView.id);
            },
          ),

          settingTile(
            icon: Icons.language,
            title: "لغة التطبيق",
            subtitle: "تغيير لغة التطبيق",
            onTap: () {
              Navigator.pushNamed(context, LanguageView.id);
            },
          ),

          settingTile(
            icon: Icons.palette_outlined,
            title: "المظهر",
            subtitle: "تخصيص شكل التطبيق",
            onTap: () {
              // Navigator.pushNamed(context, ThemeView.id);
            },
          ),

          settingTile(
            icon: Icons.info_outline,
            title: "عن التطبيق",
            subtitle: "الإصدار ومعلومات التطبيق",
            onTap: () {
              Navigator.pushNamed(context, AboutView.id);
            },
          ),
        ],
      ),
    );
  }
}
