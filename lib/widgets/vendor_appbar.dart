import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/widgets/search_card.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';

import '../models/search_product_model.dart';
import '../providers/store_provider.dart';

class VendorAppBar extends StatefulWidget {
  const VendorAppBar({Key? key}) : super(key: key);

  @override
  State<VendorAppBar> createState() => _VendorAppBarState();
}

class _VendorAppBarState extends State<VendorAppBar> {
  static List<Product> products = [];
  String offer = "";
  String shopName = "";
  DocumentSnapshot? document;

  @override
  void initState() {
    FirebaseFirestore.instance.collection("products").get().then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          setState(() {
            document = doc;
            Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

            if (data != null) {
              offer = ((data["comparedPrice"] - data["price"]) /
                      data["comparedPrice"] *
                      100)
                  .toStringAsFixed(0);
              products.add(Product(
                productName: data["productName"],
                category: data["category"]["mainCategory"],
                image: data["productImage"],
                weight: data["weight"],
                brand: data["brand"],
                shopName: data["seller"]["shopName"],
                price: data["price"],
                comparedPrice: data["comparedPrice"],
                document: doc,
              ));
            }
          });
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    products.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _store = Provider.of<StoreProvider>(context);

    mapLauncher() async {
      GeoPoint location = _store.storedetails!["location"];
      final availableMaps = await MapLauncher.installedMaps;
      await availableMaps.first.showMarker(
        coords: Coords(location.latitude, location.longitude),
        title: "${_store.storedetails!["shopName"]} is here",
      );
    }

    return SliverAppBar(
      floating: true,
      snap: true,
      iconTheme: const IconThemeData(
        color: Colors.white, // to make back button white
      ),
      expandedHeight: 260,
      flexibleSpace: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(top: 86),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(_store.storedetails!["imageUl"] ?? ""),
                  ),
                ),
                child: Container(
                  color: Colors.grey.withOpacity(.7),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Text(
                          _store.storedetails!["dialog"] ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          _store.storedetails!["address"] ?? "",
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          _store.storedetails!["email"] ?? "",
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Distance : ${_store.distance}km",
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            for (int i = 0; i < 5; i++) // Rating stars
                              const Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "(3.5)",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  // launch("tel:${_store.storedetails!["mobile"]
                                },
                                icon: const Icon(
                                  Icons.phone,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  mapLauncher();
                                },
                                icon: const Icon(
                                  Icons.map,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              shopName = _store.storedetails!["shopName"] ?? "";
            });
            showSearch(
              context: context,
              delegate: SearchPage<Product>(
                onQueryUpdate: (S) => print(S),
                items: products,
                searchLabel: "Search Products",
                suggestion: const Center(
                  child: Text("Filter products by name, category or price "),
                ),
                failure: const Center(
                  child: Text("No product found : ( "),
                ),
                filter: (product) => [
                  product.productName,
                  product.category,
                  product.brand,
                  product.price.toString(),
                ],
                builder: (product) => product.shopName != shopName
                    ? Container()
                    : SearchCard(
                        offer: offer,
                        product: product,
                        document: product.document,
                      ),
              ),
            );
          },
          icon: const Icon(CupertinoIcons.search),
        ),
      ],
      title: Text(
        _store.storedetails!["shopName"] ?? "",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
