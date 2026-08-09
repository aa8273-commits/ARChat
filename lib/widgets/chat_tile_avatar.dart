import 'package:chatt/view/user_profile_view.dart';
import 'package:chatt/widgets/group_info_widget.dart';
import 'package:flutter/material.dart';

class ChatTileAvatar extends StatelessWidget {
  const ChatTileAvatar({
    super.key,
    required this.isGroup,
    required this.conversationId,
    required this.uid,
    required this.image,
    required this.online,
  });

  final bool isGroup;
  final String? conversationId;
  final String uid;
  final String? image;
  final bool online;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(2.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.orange, width: 2.5),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),

            onTap: () {
              if (isGroup) {
                if (conversationId == null || conversationId!.isEmpty) {
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        GroupInfoView(conversationId: conversationId!),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => UserProfileView(uid: uid)),
                );
              }
            },

            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white24,

              backgroundImage:
                  image != null &&
                      image!.isNotEmpty &&
                      image!.startsWith("http")
                  ? NetworkImage(image!)
                  : null,

              child:
                  image == null || image!.isEmpty || !image!.startsWith("http")
                  ? Icon(
                      isGroup ? Icons.groups : Icons.person,
                      size: 30,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
        ),

        if (online && !isGroup)
          Positioned(
            bottom: 3,
            right: 3,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xff08131F), width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
