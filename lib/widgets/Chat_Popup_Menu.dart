import 'package:chatt/view/login_view.dart';
import 'package:chatt/view/profile_view.dart';
import 'package:chatt/view/settings_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatPopupMenu extends StatelessWidget {
  const ChatPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: const Color.fromARGB(221, 16, 15, 15),
      icon: const Icon(Icons.more_vert, color: Colors.white),

      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              FaIcon(FontAwesomeIcons.user, color: Colors.white, size: 18),
              // Icon(Icons.person_outline),
              SizedBox(width: 10),
              Text("الملف الشخصي", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),

        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              FaIcon(FontAwesomeIcons.cog, color: Colors.white, size: 18),
              SizedBox(width: 10),
              Text("الإعدادات", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),

        PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.redAccent,
                size: 18,
              ),
              SizedBox(width: 10),
              Text("تسجيل الخروج", style: TextStyle(color: Colors.redAccent)),
            ],
          ),
        ),
      ],

      onSelected: (value) async {
        switch (value) {
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileView()),
            );
            break;

          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsView()),
            );
            break;

          case 3:
            await FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
                  'isOnline': false,
                  'lastSeen': FieldValue.serverTimestamp(),
                });

            await FirebaseAuth.instance.signOut();

            Navigator.pushReplacementNamed(context, LoginView.id);
            break;
        }
      },
    );
  }
}
