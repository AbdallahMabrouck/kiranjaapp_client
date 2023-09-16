/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/store_provider.dart';
import '../../services/product_services.dart';

class ProductFilterWidget extends StatefulWidget {
  const ProductFilterWidget({super.key});

  @override
  State<ProductFilterWidget> createState() => _ProductFilterWidgetState();
}

class _ProductFilterWidgetState extends State<ProductFilterWidget> {
  final List<String> _subCatList = [];
  final ProductServices _services = ProductServices();

  @override
  void didChangeDependencies() {
    var _store = Provider.of<StoreProvider>(context);

    FirebaseFirestore.instance
        .collection("products")
        .where("category.mainCategory",
            isEqualTo: _store.selectedProductCategory)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _subCatList.add(doc["category"]["subCategory"]);
        });
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var _storeData = Provider.of<StoreProvider>(context);

    return FutureBuilder<DocumentSnapshot>(
      future: _services.category.doc(_storeData.selectedProductCategory).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (!snapshot.hasData) {
          return Container();
        }

        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

        return Container(
          height: 50,
          color: Colors.grey,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(
                width: 10,
              ),
              ActionChip(
                label: Text("All ${_storeData.selectedProductCategory}"),
                onPressed: () {
                  _storeData.selectedCategorySub(null);
                  // this will remove filter
                },
                backgroundColor: Colors.white,
                elevation: 4,
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: _subCatList.contains(data["subCat"][index]["name"])
                        ? ActionChip(
                            onPressed: () {
                              _storeData.selectedCategorySub(
                                  data["subCat"][index]["name"]);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            elevation: 4,
                            backgroundColor: Colors.white,
                            label: Text(
                              data["subCat"][index]["name"],
                            ),
                          )
                        : Container(),
                  );
                },
                itemCount: data["subCat"].length,
              )
            ],
          ),
        );
      },
    );
  }
}
*/