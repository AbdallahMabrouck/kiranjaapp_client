import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/services/cart_services.dart';

class CartProvider with ChangeNotifier {
  final CartServices _cart = CartServices();
  double subTotal = 0.0;
  int cartQty = 0;
  QuerySnapshot? snapshot;

  Future<double?> getCartTotal() async {
    var cartTotal = 0.0;
    QuerySnapshot? snapshot =
        await _cart.cart.doc(_cart.user!.uid).collection("products").get();

    if (snapshot.isNull) {
      return null;
    }

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      if (data.containsKey("total")) {
        final total = data["total"] as double?;
        if (total != null) {
          cartTotal += total;
        }
      }
    }

    subTotal = cartTotal;
    cartQty = snapshot.size;
    this.snapshot = snapshot;
    notifyListeners();

    return cartTotal;
  }
}












/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/services/cart_services.dart';

class CartProvider with ChangeNotifier {
  final CartServices _cart = CartServices();
  double subTotal = 0.0;
  int cartQty = 0;
  QuerySnapshot snapshot;

  Future<double> getCartTotal() async {
    var cartTotal = 0.0;
    QuerySnapshot snapshot =
        await _cart.cart.doc(_cart.user!.uid).collection("products").get();
    if (snapshot == null) {
      return null;
    }
    snapshot.docs.forEach((doc) {
      cartTotal = cartTotal + doc.data()["total"];
    });

    subTotal = cartTotal;
    cartQty = snapshot.size;
    snapshot = snapshot;
    notifyListeners();

    return cartTotal;
  }
}*/
