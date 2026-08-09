import 'package:chatt/cubit/nofication_cubit.dart';
import 'package:chatt/view/Notifications_View.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.08),
            borderRadius: BorderRadius.circular(15),
          ),
          child: IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.bell,
              color: Colors.orangeAccent,
              size: 18,
            ),
            onPressed: () {
              context.read<NotificationCubit>().resetNotifications(
                FirebaseAuth.instance.currentUser!.uid,
              );

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsView()),
              );
            },
          ),
        ),
        Positioned(
          right: 4,
          top: 4,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("notifications")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("items")
                .snapshots(),

            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              }

              final count = snapshot.data!.docs.length;

              if (count == 0) {
                return const SizedBox();
              }

              return Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "$count",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
