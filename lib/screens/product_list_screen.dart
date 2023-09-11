import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/store_provider.dart';
import '../widgets/products/product_filter_widget.dart';
import '../widgets/products/product_list_widget.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  static const String id = "product-list-screen";

  @override
  Widget build(BuildContext context) {
    var _storeProvider = Provider.of<StoreProvider>(context);

    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            floating: true,
            snap: true,
            title: Text(
              _storeProvider.selectedProductCategory,
              style: const TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            expandedHeight: 110,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 88),
              child: Container(
                height: 56,
                color: Colors.grey,
                child: const ProductFilterWidget(),
              ),
            ),
          ),
        ];
      },
      body: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: const [
          ProductListWidget(),
        ],
      ),
    ));
  }
}
