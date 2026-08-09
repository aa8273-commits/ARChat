import 'package:chatt/widgets/home_popup_menu.dart';
import 'package:chatt/widgets/notification_button.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
      child: Row(
        children: [
          IconTheme(
            data: const IconThemeData(color: Colors.orangeAccent, size: 30),
            child: DrawerButton(),
          ),

          const SizedBox(width: 15),

          const Expanded(
            child: Text(
              "AR Chat",
              style: TextStyle(
                fontFamily: "Pacifico",
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),

          NotificationButton(),

          const SizedBox(width: 10),

          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.08),
              borderRadius: BorderRadius.circular(15),
            ),
            child: HomePopupMenu(),
          ),
        ],
      ),
    );
  }
}
