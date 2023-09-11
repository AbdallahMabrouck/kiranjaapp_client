import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../providers/store_provider.dart';
import '../../screens/product_list_screen.dart';
import '../../services/product_services.dart';

class VendorCategories extends StatefulWidget {
  const VendorCategories({super.key});

  @override
  State<VendorCategories> createState() => _VendorCategoriesState();
}

class _VendorCategoriesState extends State<VendorCategories> {
  final ProductServices _services = ProductServices();

  final List<String> _catList = [];

  @override
  void didChangeDependencies() {
    var _store = Provider.of<StoreProvider>(context, listen: false);

    FirebaseFirestore.instance
        .collection("products")
        .where("seller.sellerUid", isEqualTo: _store.storedetails!["uid"])
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _catList.add(doc["category"]["mainCategory"]);
        });
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var _storeProvider = Provider.of<StoreProvider>(context, listen: false);

    return FutureBuilder<QuerySnapshot>(
        future: _services.category.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong ..."),
            );
          }
          if (_catList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Container();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("images/background.JPG")),
                      ),
                      child: const Center(
                        child: Text(
                          "Shop by Category",
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 3.0,
                                    color: Colors.black)
                              ],
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  children: List<Widget>.generate(snapshot.data!.docs.length,
                      (int index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    return _catList.contains(document.get("name"))
                        ? InkWell(
                            onTap: () {
                              _storeProvider
                                  .selectedCategory(document.get("name"));
                              _storeProvider.selectedCategorySub(null);
                              PersistentNavBarNavigator
                                  .pushNewScreenWithRouteSettings(
                                context,
                                settings: const RouteSettings(
                                    name: ProductListScreen.id),
                                screen: const ProductListScreen(),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: SizedBox(
                              width: 120,
                              height: 150,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Column(
                                  children: [
                                    Center(
                                      child:
                                          Image.network(document.get("image")),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: Text(
                                        document.get("name"),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox();
                  }),
                ),
              ],
            ),
          );
        });
  }
}





/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../provider/store_provider.dart';
import '../../screens/product_list_screen.dart';
import '../../services/product_services.dart';

class VendorCategories extends StatefulWidget {
  const VendorCategories({super.key});

  @override
  State<VendorCategories> createState() => _VendorCategoriesState();
}

class _VendorCategoriesState extends State<VendorCategories> {
  final ProductServices _services = ProductServices();

  final List _catList = [];

  @override
  void didChangeDependencies() {
    var _store = Provider.of<StoreProvider>(context);

    FirebaseFirestore.instance
        .collection("products")
        .where("seller.sellerUid", isEqualTo: _store.storedetails!["uid"])
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                setState(() {
                  _catList.add(doc["category"]["mainCategory"]);
                });
              })
            });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var _storeProvider = Provider.of<StoreProvider>(context);

    return FutureBuilder(
        future: _services.category.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong ..."),
            );
          }
          if (_catList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Container();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("images/background.JPG")),
                      ),
                      child: const Center(
                        child: Text(
                          "Shop by Category",
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 3.0,
                                    color: Colors.black)
                              ],
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    return _catList.contains(document.data()["name"])
                        ? InkWell(
                            onTap: () {
                              _storeProvider
                                  .selectedCategory(document.data()["name"]);
                              _storeProvider.selectedCategorySub(null);
                              PersistentNavBarNavigator
                                  .pushNewScreenWithRouteSettings(
                                context,
                                settings: const RouteSettings(
                                    name: ProductListScreen.id),
                                screen: const ProductListScreen(),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: SizedBox(
                              width: 120,
                              height: 150,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Image.network(
                                          document.data()["image"]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: Text(
                                        document.data()["name"],
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const Text(" ");
                  }).toList(),
                ),
              ],
            ),
          );
        });
  }
}*/
