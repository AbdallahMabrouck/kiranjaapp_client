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

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio:
                          snapshot.docs.isEmpty ? 1 / 0.1 : 1 / 1.1),
                  itemCount: snapshot.docs.length,
                  itemBuilder: (context, index) {
                    SubCategory subCat = snapshot.docs[index].data();
                    return InkWell(
                      onTap: () {
                        // move to products screen
                      },
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: subCat.image!,
                                  placeholder: (context, _) {
                                    return Container(
                                      height: 60,
                                      width: 60,
                                      color: Colors.grey.shade300,
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      height: 60,
                                      width: 60,
                                      color: Colors.red,
                                      child: const Icon(
                                        Icons.error,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Text(
                              subCat.subCatName!,
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        );
      },
    ));
  }
}
