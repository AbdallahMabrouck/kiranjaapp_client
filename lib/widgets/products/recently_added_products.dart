/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/services/product_services.dart';
import 'package:kiranjaapp_client/widgets/products/product_card_widget.dart';
import 'package:provider/provider.dart';
import '../../providers/store_provider.dart';

class RecentlyAddedProducts extends StatelessWidget {
  const RecentlyAddedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    ProductServices _services = ProductServices();
    var _store = Provider.of<StoreProvider>(context);

    return FutureBuilder<QuerySnapshot>(
      future: _services.products
          .where("published", isEqualTo: true)
          .where("collection", isEqualTo: "Recently Added")
          .where("seller.sellerUid", isEqualTo: _store.storedetails?["uid"])
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Container();
        }

        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            snapshot.data! as QuerySnapshot<Map<String, dynamic>>;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      "Recently Added",
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          )
                        ],
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: querySnapshot.docs
                  .map((DocumentSnapshot<Map<String, dynamic>> document) {
                return ProductCard(
                  document: document,
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
*/