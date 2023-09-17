import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductBottomSheet extends StatelessWidget {
  final Product? product;
  const ProductBottomSheet({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    Widget _customContainer({String? head, String? details}) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              head!,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 6, bottom: 6),
              child: Row(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(details!),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      );
    }

    return Container(
      height: 600,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: const Text(
              "Specifications",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product!.brand != null)
                  _customContainer(head: "Brand", details: product!.brand),
                if (product!.unit != null)
                  _customContainer(head: "Unit", details: product!.unit),
                if (product!.otherDetails != null) Text(product!.otherDetails!),
                const SizedBox(
                  height: 10,
                ),
                if (product!.sku != null)
                  _customContainer(head: "SKU", details: product!.sku),
              ],
            ),
          )
        ],
      ),
    );
  }
}
