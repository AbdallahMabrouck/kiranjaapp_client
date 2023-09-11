import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/services/product_services.dart';
import 'package:kiranjaapp_client/widgets/products/product_card_widget.dart';
import 'package:provider/provider.dart';

import '../../providers/store_provider.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductServices _services = ProductServices();

    var _store = Provider.of<StoreProvider>(context);

    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: _services.products
              .where("published", isEqualTo: true)
              .where("category.mainCategory",
                  isEqualTo: _store.selectedProductCategory)
              .where("category.subCategory", isEqualTo: _store.selectedSubCategory)
              .where("seller.sellerUid", isEqualTo: _store.storedetails!["uid"])
              // .limitToLast(10)
              .get()
          as Future<QuerySnapshot<Map<String, dynamic>>>, // Explicit cast here
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Container(); // No data
        }

        return Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "${snapshot.data!.docs.length} Items",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: snapshot.data!.docs
                  .map((DocumentSnapshot<Map<String, dynamic>> document) {
                return ProductCard(document: document);
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
