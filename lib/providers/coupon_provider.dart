import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CouponProvider with ChangeNotifier {
  bool? expired; // Nullable
  DocumentSnapshot? document; // Nullable
  int discountRate = 0;

  Future<void> getCouponDetails(String title, String sellerId) async {
    DocumentSnapshot? document =
        await FirebaseFirestore.instance.collection("coupons").doc(title).get();
    if (document.exists) {
      this.document = document;
      notifyListeners();
      final Map<String, dynamic>? data = document.data()
          as Map<String, dynamic>?; // Use as Map<String, dynamic>?
      if (data != null && data["sellerId"] == sellerId) {
        checkExpiry(document);
      }
    } else {
      this.document = null;
      notifyListeners();
    }
  }

  void checkExpiry(DocumentSnapshot document) {
    final Map<String, dynamic>? data = document.data()
        as Map<String, dynamic>?; // Use as Map<String, dynamic>?
    if (data != null) {
      DateTime? expiryDate =
          (data["Expiry"] as Timestamp?)?.toDate(); // Nullable
      if (expiryDate != null) {
        var dateDiff = expiryDate.difference(DateTime.now()).inDays;
        if (dateDiff < 0) {
          // coupon expired
          expired = true;
          notifyListeners();
        } else {
          this.document = document;
          expired = false;
          discountRate = data["discountRate"] ?? 0; // Provide a default value
          notifyListeners();
        }
      }
    }
  }
}





















/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class CouponProvider with ChangeNotifier {
  bool expired;
  DocumentSnapshot document;
  int discountRate = 0;


  getCouponDetails (title, sellerId) async {
    DocumentSnapshot document = 
    await FirebaseFirestore.instance.collection("coupons").doc(title).get();
    if(document.exists){
      this.document = document;
      notifyListeners();
      if(document.data()["sellerId"] == sellerId){
        checkExpiry(document);
      }
    } else {
      this.document = null;
      notifyListeners();
    }
  }

  checkExpiry(DocumentSnapshot document){
    DateTime date = document.data()["Expiry"].toDate();
    var dateDiff = date.difference(DateTime.now()).inDays;
    if(dateDiff<0){
      // coupon expired
      this.expired = true;
      notifyListeners();
    } else {
      this.document = document;
      this.expired = false;
      this.discountRate = document.data()["discountRate"];
      notifyListeners();
    }
  }
}*/