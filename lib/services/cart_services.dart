/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartServices {
  CollectionReference cart = FirebaseFirestore.instance.collection("cart");
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> addToCart(DocumentSnapshot document) async {
    await cart.doc(user!.uid).set({
      "user": user!.uid,
      "sellerUid": document["sellerUid"],
      "shopName": document["shopName"],
    });

    await cart.doc(user!.uid).collection("products").add({
      "productId": document["productId"],
      "productName": document["productName"],
      "weight": document["weight"],
      "price": document["price"],
      "comparedPrice": document["comparedPrice"],
      "sku": document["sku"],
      "qty": 1,
      "total": document["price"]
      // totl proce for 1 qty
    });
  }

  Future<void> updateCartQty(String docId, int qty, total) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("cart")
        .doc(user!.uid)
        .collection("products")
        .doc(docId);

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(documentReference);
          if (!snapshot.exists) {
            throw Exception("Product does not exist in Cart!");
          }

          transaction.update(documentReference, {
            "qty": qty,
            "total": total,
          });
          // return the new cont
          return qty;
        })
        .then((value) => print("update Cart"))
        .catchError((error) => print("Failed to update Cart: $error"));
  }

  Future<void> removeFromCart(String docId) async {
    await cart.doc(user!.uid).collection("products").doc(docId).delete();
  }

  Future<void> checkData() async {
    final snapshot = await cart.doc(user!.uid).collection("products").get();
    if (snapshot.docs.isEmpty) {
      await cart.doc(user!.uid).delete();
    }
  }

  Future<void> deleteCart() async {
    final snapshot = await cart.doc(user!.uid).collection("products").get();
    for (DocumentSnapshot ds in snapshot.docs) {
      await ds.reference.delete();
    }
  }

  Future<String?> checkSeller() async {
    final snapshot = await cart.doc(user!.uid).get();
    return snapshot.exists ? snapshot["shopName"] : null;
  }
}



*/




/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartServices {
  CollectionReference cart = FirebaseFirestore.instance.collection("cart");
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> addToCart(document) {
    cart.doc(user!.uid).set({
      "user": user!.uid,
      "sellerUid": document.data()["sellerUid"],
      // if you want a customer to add products to cart from different suppliers,
      // remove the above detail details from here
      "shopName": document.data()["shopName"],
      //  the above is sellers details
    });
    return cart.doc(user!.uid).collection("products").add({
      "productId": document.data()["productId"],
      "productName": document.data()["productName"],
      "weight": document.data()["weight"],
      "price": document.data()["price"],
      "comparedPrice": document.data()["comparedPrice"],
      "sku": document.data()["sku"],
      "qty": 1

      // and add here
      // "sellerUid": document.data()["sellerUid"],
    });
  }

  Future<void> updateCartQty(docId, qty) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("cart")
        .doc(user!.uid)
        .collection("products")
        .doc(docId);

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          // get the document
          DocumentSnapshot snapshot = await transaction.get(documentReference);
          if (snapshot.exists) {
            throw Exception("Product does not exist in Cart!");
          }

          // perform an update on the document
          transaction.update(documentReference, {"qty": qty});

          return qty;
        })
        .then((value) => print("update Cart"))
        .catchError((erro) => print("Failed to update Cart: $erro"));
  }

  Future<void> removeFromCart(docId) async {
    cart.doc(user!.uid).collection("products").doc(docId).delete();
  }

  Future<void> checkData() async {
    final snapshot = await cart.doc(user!.uid).collection("products").get();
    if (snapshot.docs.isEmpty) {
      cart.doc(user!.uid).delete();
    }
  }

  Future<void> deleteCart() async {
    final result =
        await cart.doc(user!.uid).collection("products").get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  Future<String> checkSeller() async {
    final snapshot = await cart.doc(user!.uid).get();
    return snapshot.exists ? snapshot.data()["shopName"] : null;
  }
}*/
