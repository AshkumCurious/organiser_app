import 'package:flutter/material.dart';
import 'package:organiser_app/screens/extra.dart';
import 'package:organiser_app/screens/home.dart';
import 'package:organiser_app/screens/task.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.child});
  final Widget child;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> _screens = [const Home(), const Tasks(), const Extra()];
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: PersistentTabView(
        context,
        controller: _controller,
        screens: _screens,
        decoration: NavBarDecoration(borderRadius: BorderRadius.circular(25)),
        margin: const EdgeInsets.all(10),
        items: [
          PersistentBottomNavBarItem(
              icon: const Icon(Icons.home_filled),
              activeColorPrimary: Colors.deepPurpleAccent,
              inactiveColorPrimary: Colors.grey),
          PersistentBottomNavBarItem(
              icon: const Icon(Icons.list),
              activeColorPrimary: Colors.deepPurpleAccent,
              inactiveColorPrimary: Colors.grey),
          PersistentBottomNavBarItem(
              icon: const Icon(Icons.more_horiz),
              activeColorPrimary: Colors.deepPurpleAccent,
              inactiveColorPrimary: Colors.grey),
        ],
      ),
    );
  }
}
