import '../firebase_services.dart';

class SubCategory {
  SubCategory({this.mainCategory, this.subCatName, required this.image});

  SubCategory.fromJson(Map<String, Object?> json)
      : this(
          mainCategory: json['mainCategory']! as String,
          subCatName: json['subCatName']! as String,
          image: json['image']! as String,
        );

  final String? mainCategory;
  final String? subCatName;
  final String? image;

  Map<String, Object?> toJson() {
    return {
      'mainCategory': mainCategory,
      'subCatName': subCatName,
      'image': image,
    };
  }
}

FirebaseService _service = FirebaseService();
subCategoryCollection({selectedSubCat}) {
  return _service.subCategories
      .where("active", isEqualTo: true)
      .where("subCatNmae", isEqualTo: selectedSubCat)
      .withConverter<SubCategory>(
        fromFirestore: (snapshot, _) => SubCategory.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );
}
