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
        appBar: AppBar(
          backgroundColor: Colors.blue,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.white,
                ),
              ),
            )
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      fillColor: Colors.white),
                ),
              )),
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
