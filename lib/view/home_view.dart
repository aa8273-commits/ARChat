import 'package:chatt/view/calls_view.dart';
import 'package:chatt/view/contacts_view.dart';
import 'package:chatt/view/updates_view.dart';
import 'package:chatt/widgets/RecentChats_Widget.dart';
import 'package:chatt/widgets/app_drawer.dart';
import 'package:chatt/widgets/home_app_bar.dart';
import 'package:chatt/widgets/home_body.dart';
import 'package:chatt/widgets/search_bar_widget.dart';
import 'package:chatt/widgets/updates_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String id = "home";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String searchText = "";
  int currentIndex = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget chatsPage() {
    return SafeArea(
      child: Column(
        children: [
          const HomeAppBar(),

          const SizedBox(height: 18),

          SearchWidget(
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
          ),
          const SizedBox(height: 20),
          const UpdatesWidget(),
          const SizedBox(height: 20),

          Expanded(child: RecentChatsWidget(searchText: searchText)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      chatsPage(),
      const UpdatesView(),
      const CallsView(),
      const ContactsView(),
    ];
    return Scaffold(
      backgroundColor: const Color(0xff08131F),
      drawer: const AppDrawer(),
      body: homeBody(pages: pages, currentIndex: currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: changePage,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff0F2742),
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.white70,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_rounded),
            activeIcon: Icon(Icons.chat),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update_outlined),
            activeIcon: Icon(Icons.update),
            label: "Updates",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_outlined),
            activeIcon: Icon(Icons.call),
            label: "Calls",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: "Contacts",
          ),
        ],
      ),
    );
  }
}
