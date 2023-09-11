import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../models/search_product_model.dart';
import '../screens/product_details_screen.dart';
import 'cart/counter.dart';

class SearchCard extends StatelessWidget {
  const SearchCard(
      {super.key,
      required this.offer,
      required this.product,
      required this.document});

  final String offer;
  final Product product;
  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(width: 1, color: Colors.grey.shade300)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
        child: Row(
          children: [
            Stack(
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                        context,
                        settings:
                            const RouteSettings(name: ProductDetailsScreen.id),
                        screen: const ProductDetailsScreen(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: SizedBox(
                      height: 140,
                      width: 130,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Hero(
                          tag:
                              "product${product.document.data()!["productName"]}",
                          child: Image.network(
                              product.document.data()!["productImage"]),
                        ),
                      ),
                    ),
                  ),
                ),
                if (product.document.data()!["comparedPrice"] > 0)
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 3, bottom: 3, left: 10, right: 10),
                      child: Text(
                        "$offer %OFF",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.document.data()!["brand"],
                          style: const TextStyle(fontSize: 10),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          product.document.data()!["productName"],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: MediaQuery.of(context).size.width - 160,
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey.shade200,
                          ),
                          child: Text(
                            product.document.data()!["weight"],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              "\$${product.document.data()!["price"].toStringAsFixed(0)}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            if (product.document.data()!["comparedPrice"] > 0)
                              Text(
                                "\$${product.document.data()!["comparedPrice"].toStringAsFixed(0)}",
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CounterForCard(
                              document: product.document,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
