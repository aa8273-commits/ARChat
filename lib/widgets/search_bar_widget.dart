import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.25),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
          color: Colors.white.withOpacity(.08),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(.08)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 18),

            Icon(Icons.search, color: Colors.white.withOpacity(.7), size: 24),

            const SizedBox(width: 15),

            Expanded(
              child: TextField(
                onChanged: onChanged,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.orangeAccent,
                decoration: InputDecoration(
                  hintText: "Search conversations...",
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(.45),
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(right: 8),
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.sliders,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
