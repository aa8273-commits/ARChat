import 'package:chatt/view/Splash_view.dart';
import 'package:chatt/view/about_view.dart';
import 'package:chatt/view/calls_view.dart';
import 'package:chatt/view/contacts_view.dart';
import 'package:chatt/view/home_view.dart';
import 'package:chatt/view/login_view.dart';
import 'package:chatt/view/profile_view.dart';
import 'package:chatt/view/saved_messages_view.dart';
import 'package:chatt/view/settings_view.dart';
import 'package:chatt/view/updates_view.dart';
import 'package:chatt/widgets/DrawerItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.image,
    required this.name,
    required this.email,
  });

  final dynamic image;
  final dynamic name;
  final dynamic email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff08131F),
      child: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xff0F2742),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ProfileView()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 40,

                      backgroundImage: image.isNotEmpty
                          ? NetworkImage(image)
                          : null,

                      child: image.isEmpty
                          ? const Icon(
                              Icons.person,
                              size: 45,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(email, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),

            const SizedBox(height: 15),

            DrawerItem(
              icon: Icons.person,
              title: "الملف الشخصي",

              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, ProfileView.id);
              },
            ),

            DrawerItem(
              icon: Icons.chat,
              title: "المحادثات",
              onTap: () {
                // Navigator.pop(context);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeView()),
                );
              },
            ),

            DrawerItem(
              icon: Icons.update,
              title: "التحديثات",

              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const UpdatesView()),
                );
              },
            ),

            DrawerItem(
              icon: Icons.call,
              title: "المكالمات",

              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, CallsView.id);
              },
            ),

            DrawerItem(
              icon: Icons.people,
              title: "جهات الاتصال",

              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, ContactsView.id);
              },
            ),

            DrawerItem(
              icon: Icons.bookmark,
              title: "الرسائل المحفوظة",

              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, SavedMessagesView.id);
              },
            ),

            DrawerItem(
              icon: Icons.settings,
              title: "الإعدادات",

              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(context, SettingsView.id);
              },
            ),

            DrawerItem(
              icon: Icons.info_outline,
              title: "حول التطبيق",

              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AboutView.id);
              },
            ),

            const SizedBox(height: 20),

            DrawerItem(
              icon: Icons.logout,
              title: "تسجيل الخروج",

              color: Colors.red,

              onTap: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.pushReplacementNamed(context, SplashHomeView.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
