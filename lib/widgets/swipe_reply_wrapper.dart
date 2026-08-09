import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatt/cubit/ChatCubit.dart';
import 'package:chatt/modols/message.dart';

class SwipeReplyWrapper extends StatefulWidget {
  const SwipeReplyWrapper({
    super.key,
    required this.child,
    required this.message,
  });

  final Widget child;
  final Message message;

  @override
  State<SwipeReplyWrapper> createState() => _SwipeReplyWrapperState();
}

class _SwipeReplyWrapperState extends State<SwipeReplyWrapper> {
  double dragX = 0;

  static const double maxSwipe = 80;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          setState(() {
            dragX += details.delta.dx;

            if (dragX > maxSwipe) {
              dragX = maxSwipe;
            }
          });
        }
      },

      onHorizontalDragEnd: (_) {
        if (dragX >= 50) {
          context.read<ChatCubit>().setReplyMessage(widget.message);
        }

        setState(() {
          dragX = 0;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,

        transform: Matrix4.translationValues(dragX, 0, 0),

        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            if (dragX > 15)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(Icons.reply, color: Colors.orangeAccent, size: 28),
              ),

            Transform.translate(offset: Offset(dragX, 0), child: widget.child),
          ],
        ),
      ),
    );
  }
}
