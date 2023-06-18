import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../screens/account_screen.dart';
import '../screens/categories_screen.dart';
import '../screens/explore_screen.dart';
import '../screens/home_screen.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  static const String id = "bottom-navigation";

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(
      index: 0,
    ),
    CategoriesScreen(),
    ExploreScreen(),
    AccountScreen(),
  ];

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _selectedIndex = 0;

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BottomNavigationWidget._widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            child: GNav(
              color: Colors.black,
              activeColor: Colors.blue.shade900,
              tabBackgroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
              duration: const Duration(milliseconds: 50),
              iconSize: 28,
              hoverColor: Colors.white,
              rippleColor: Colors.white,
              textSize: 45.0,
              gap: 8,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                  onPressed: _onItemTapped(0),
                ),
                GButton(
                  icon: Icons.dashboard_rounded,
                  text: "Categories",
                  onPressed: _onItemTapped(1),
                ),
                GButton(
                  icon: Icons.explore_rounded,
                  text: "Explore",
                  onPressed: _onItemTapped(2),
                ),
                GButton(
                  icon: Icons.account_circle_rounded,
                  text: "Account",
                  onPressed: _onItemTapped(3),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
