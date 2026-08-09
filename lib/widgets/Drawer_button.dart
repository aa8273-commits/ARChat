import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.08),
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const FaIcon(
          FontAwesomeIcons.bars,
          color: Colors.orangeAccent,
          size: 18,
        ),
      ),
    );
  }
}
