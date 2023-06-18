import '../firebase_services.dart';

class Category {
  Category({this.catName, this.image});

  Category.fromJson(Map<String, Object?> json)
      : this(
          catName: json['catName']! as String,
          image: json['image']! as String,
        );

  final String? catName;
  final String? image;

  Map<String, Object?> toJson() {
    return {
      'catName': catName,
      'image': image,
    };
  }
}

FirebaseService _service = FirebaseService();
final categoryCollection = _service.categories
    .where("active", isEqualTo: true)
    .withConverter<Category>(
      fromFirestore: (snapshot, _) => Category.fromJson(snapshot.data()!),
      toFirestore: (movie, _) => movie.toJson(),
    );
