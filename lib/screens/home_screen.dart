import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../widgets/banner_widget.dart';
import '../widgets/brand_highlights_widget.dart';
import '../widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required int index});
  static const String id = "home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,

        // ========== App bar starts here ======================
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            centerTitle: false,
            title: const Text(
              "Kiranja",
              style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),

        body: ListView(
          children: const [
            SearchWidget(),
            SizedBox(
              height: 10,
            ),
            BannerWidget(),
            BrandHighlights(),
            // CategoryWidget(),
          ],
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
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: "Home",
                  ),
                  GButton(
                    icon: Icons.dashboard_rounded,
                    text: "Categories",
                  ),
                  GButton(
                    icon: Icons.explore_rounded,
                    text: "Explore",
                  ),
                  GButton(
                    icon: Icons.account_circle_rounded,
                    text: "Account",
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
      ),
    );
  }
}
