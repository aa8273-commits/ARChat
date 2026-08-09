import 'package:chatt/widgets/Chat_Popup_Menu.dart';
import 'package:chatt/widgets/Chat_User_Info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({
    super.key,
    required this.receiverId,
    required this.conversationId,
    required this.isGroup,
  });

  final String receiverId;

  final String conversationId;
  final bool isGroup;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xff08131F),
      elevation: 0,
      titleSpacing: 10,

      title: ChatUserInfo(
        receiverId: receiverId,
        conversationId: conversationId,
        isGroup: isGroup,
      ),

      actions: [
        IconButton(
          tooltip: "مكالمة صوتية",
          icon: const FaIcon(
            FontAwesomeIcons.phone,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {},
        ),

        IconButton(
          tooltip: "مكالمة فيديو",
          icon: const FaIcon(
            FontAwesomeIcons.video,
            color: Colors.white,
            size: 20,
          ),

          onPressed: () {},
        ),

        ChatPopupMenu(),
      ],
    );
  }
}
