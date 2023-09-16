/*import 'package:cloud_firestore/cloud_firestore.dart';

class StoreServices {
  CollectionReference vendorbanner =
      FirebaseFirestore.instance.collection("vendorBanner");
  CollectionReference vendors =
      FirebaseFirestore.instance.collection("vendors");
  geTopPickedStore() {
    return vendors
        .where("accVerified", isEqualTo: true)
        .where("isTopPicked", isEqualTo: true)
        .orderBy("shopName")
        .snapshots();
    // this will only show verified top picked vendor from admin, sorting stores alphabetically
  }

  Future<DocumentSnapshot> getShopDetails(sellerUid) async {
    DocumentSnapshot snapshot = await vendors.doc(sellerUid).get();
    return snapshot;
  }
}*/
