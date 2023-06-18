import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../widgets/category/main_category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String _tittle = "Categories";
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          selectedCategory == null ? _tittle : selectedCategory!,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          children: [
            FirestoreListView<Category>(
              shrinkWrap: true,
              query: categoryCollection,
              itemBuilder: (context, snapshot) {
                Category category = snapshot.data();
                return InkWell(
                  onTap: () {
                    setState(() {
                      _tittle = category.catName!;
                      selectedCategory = category.catName;
                    });
                  },
                  child: Container(
                    height: 70,
                    color: selectedCategory == category.catName
                        ? Colors.white
                        : Colors.grey.shade300,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 30,
                              child: CachedNetworkImage(
                                  imageUrl: category.image!,
                                  color: selectedCategory == category.catName
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey.shade700),
                            ),
                            Text(
                              category.catName!,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: selectedCategory == category.catName
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey.shade700),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            MainCategoryWidget(
              selectedCat: selectedCategory,
            ),
          ],
        ),
      ),
    );
  }
}
