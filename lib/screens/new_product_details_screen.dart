import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/widgets/products/bottom_sheet_container.dart';

class NewProductDetailsScreen extends StatelessWidget {
  static const String id = "new-product-details-screen";
  final DocumentSnapshot? document;
  const NewProductDetailsScreen({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    if (document == null || document?.data() == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    Map<String, dynamic> data = document?.data() as Map<String, dynamic>;

    var offer =
        ((data["comparedPrice"] - data["price"]) / data["comparedPrice"]) * 100;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.search),
          ),
        ],
      ),
      bottomSheet: BottomSheetContainer(document: document!),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.3),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 2, bottom: 2),
                    child: Text(data["brand"] ?? ""),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              data["productName"] ?? "",
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              data["weight"] ?? "",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "\$${(data["price"] ?? 0).toStringAsFixed(0)}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (offer > 0)
                  // if offer available only
                  Text(
                    "\$${data["comparedPrice"] ?? ""}",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough),
                  ),
                const SizedBox(
                  width: 10,
                ),
                if (offer > 0)
                  // if offer available only
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(2)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 3, bottom: 3),
                      child: Text(
                        "${offer.toStringAsFixed(0)}% OFF",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12),
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Hero(
                  tag: "product${data["productName"]}",
                  child: Image.network(data["productImage"])),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 6,
            ),
            Container(
              child: const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  "About this product",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
              child: ExpandableText(
                data["description"] ?? "",
                expandText: "View more",
                collapseText: "View less",
                maxLines: 2,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            Container(
              child: const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  "Other Product Info",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SKU : ${data["sku"]}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Supplier : ${data["seller"]["shopName"]}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }

  Future<void> saveForLater() async {
    CollectionReference _favorite =
        FirebaseFirestore.instance.collection("favorites");
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _favorite.add({
        "product": document?.data(),
        "customerId": user.uid,
      });
    }
  }
}
