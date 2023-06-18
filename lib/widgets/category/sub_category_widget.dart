import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/sub_category_model.dart';

class SubCategoryWidget extends StatelessWidget {
  final String? selectedSubCat;
  const SubCategoryWidget({super.key, this.selectedSubCat});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FirestoreQueryBuilder<SubCategory>(
      query: subCategoryCollection(selectedSubCat: selectedSubCat),
      builder: (context, snapshot, _) {
        if (snapshot.isFetching) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('error ${snapshot.error}');
        }

        return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: snapshot.docs.isEmpty ? 1 / .1 : 1 / 1.1),
            itemCount: snapshot.docs.length,
            itemBuilder: (context, index) {
              SubCategory subCat = snapshot.docs[index].data();
              return InkWell(
                onTap: () {
                  // move to products screen
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: CachedNetworkImage(
                            imageUrl: subCat.image!,
                            placeholder: (contex, _) {
                              return Container(
                                height: 60,
                                width: 60,
                                color: Colors.grey.shade300,
                              );
                            },
                          )),
                    ),
                    Text(
                      subCat.subCatName!,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            });
      },
    ));
  }
}
