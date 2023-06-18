import 'package:flutter/material.dart';
import '../widgets/banner_widget.dart';
import '../widgets/brand_highlights_widget.dart';
import '../widgets/category/category_widget.dart';
import '../widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required int index});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        resizeToAvoidBottomInset: false,

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
            CategoryWidget(),
          ],
        ),
      ),
    );
  }
}
