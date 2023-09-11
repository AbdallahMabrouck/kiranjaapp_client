import 'package:flutter/material.dart';
import '../widgets/category/vendor_categories.dart';
import '../widgets/products/best_selling_products.dart';
import '../widgets/products/featured_products.dart';
import '../widgets/products/recently_added_products.dart';
import '../widgets/vendor_appbar.dart';
import '../widgets/vendor_banner.dart';

class VendorHomeScreen extends StatelessWidget {
  const VendorHomeScreen({super.key});

  static const String id = "vendor-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const VendorAppBar(),
            ];
          },
          body: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: const [
              VendorBanner(),
              VendorCategories(),
              RecentlyAddedProducts(),
              FeaturedProducts(),
              BestSellingProducts(),
            ],
          )),
    );
  }
}
