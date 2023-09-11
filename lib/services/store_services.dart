import 'package:cloud_firestore/cloud_firestore.dart';

class StoreServices {
  geTopPickedStore() {
    return FirebaseFirestore.instance
        .collection("vendors")
        .where("accVerified", isEqualTo: true)
        .where("isTopPicked", isEqualTo: true)
        .orderBy("shopName")
        .snapshots();
  }
}

// this will only show verified top picked vendor from admin, sorting stores alphabetically