/*import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/widgets/category/sub_category_widget.dart';

import '../../models/main_category_model.dart';

class MainCategoryWidget extends StatefulWidget {
  final String? selectedCat;
  const MainCategoryWidget({super.key, required this.selectedCat});

  @override
  State<MainCategoryWidget> createState() => _MainCategoryWidgetState();
}

class _MainCategoryWidgetState extends State<MainCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirestoreListView<MainCategory>(
        query: mainCategoryCollection(widget.selectedCat),
        itemBuilder: (context, snapshot) {
          MainCategory mainCategory = snapshot.data();
          return SingleChildScrollView(
            child: ExpansionTile(
              childrenPadding: const EdgeInsets.all(8),
              title: Text(mainCategory.mainCategory!),
              children: [
                SubCategoryWidget(selectedSubCat: mainCategory.mainCategory),
              ],
            ),
          );
        },
      ),
    );
  }
}
*/