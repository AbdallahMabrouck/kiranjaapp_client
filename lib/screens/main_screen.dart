import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'account_screen.dart';
import 'categories_screen.dart';
import 'explore_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  final int? index;
  const MainScreen({super.key, required this.index});
  static const String id = "main-screen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(
      index: 0,
    ),
    CategoriesScreen(),
    ExploreScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    if (widget.index != null) {
      setState(() {
        _selectedIndex = widget.index!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade300))),
        child: BottomNavigationBar(
          elevation: 4,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon:
                  Icon(_selectedIndex == 1 ? Icons.dashboard : Icons.dashboard),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 2 ? Icons.search : Icons.search),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 3
                  ? CupertinoIcons.person_solid
                  : CupertinoIcons.person),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue.shade800,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black87,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 13,
          selectedLabelStyle: optionStyle,
          unselectedLabelStyle: optionStyle,
        ),
      ),
    );
  }
}
