import 'package:chatt/view/contacts_view.dart';
import 'package:chatt/view/create_group_view.dart';
import 'package:chatt/view/login_view.dart';
import 'package:chatt/view/profile_view.dart';
import 'package:chatt/view/settings_view.dart';
import 'package:flutter/material.dart';

class HomePopupMenu extends StatelessWidget {
  const HomePopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert_rounded, color: Colors.orangeAccent),
      color: const Color(0xff0F2742),
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xff163B5F)),
      ),
      onSelected: (value) {
        switch (value) {
          case "new_chat":
            Navigator.pushNamed(context, ContactsView.id);
            break;

          case "new_group":
            Navigator.pushNamed(context, CreateGroupView.id);
            break;
          case "profile":
            Navigator.pushNamed(context, ProfileView.id);
            break;

          case "settings":
            Navigator.pushNamed(context, SettingsView.id);
            break;

          case "logout":
            Navigator.pushNamed(context, LoginView.id);
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: "new_chat",
          child: Row(
            children: [
              Icon(Icons.chat_bubble_outline, color: Colors.orangeAccent),
              SizedBox(width: 12),
              Text(
                "New Chat",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const PopupMenuDivider(),

        const PopupMenuItem(
          value: "new_group",
          child: Row(
            children: [
              Icon(Icons.group_add_outlined, color: Colors.orangeAccent),
              SizedBox(width: 12),
              Text(
                "New Group",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const PopupMenuItem(
          value: "profile",
          child: Row(
            children: [
              Icon(Icons.person_outline, color: Colors.orangeAccent),
              SizedBox(width: 12),
              Text(
                "Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const PopupMenuItem(
          value: "settings",
          child: Row(
            children: [
              Icon(Icons.settings_outlined, color: Colors.orangeAccent),
              SizedBox(width: 12),
              Text(
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const PopupMenuDivider(),

        const PopupMenuItem(
          value: "logout",
          child: Row(
            children: [
              Icon(Icons.logout_rounded, color: Colors.redAccent),
              SizedBox(width: 12),
              Text(
                "Logout",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
