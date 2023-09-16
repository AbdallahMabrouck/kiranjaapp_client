/*import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/services/cart_services.dart';

class CartProvider with ChangeNotifier {
  final CartServices _cart = CartServices();
  double subTotal = 0.0;
  int cartQty = 0;
  QuerySnapshot? snapshot; // Nullable
  DocumentSnapshot? document; // Nullable
  double saving = 0.0;
  double distance = 0.0;
  bool cod = false;
  List<Map<String, dynamic>> cartList = []; // Initialize as an empty list

  Future<double?> getCartTotal() async {
    var cartTotal = 0.0;
    var saving = 0.0;
    List<Map<String, dynamic>> _newList = [];
    QuerySnapshot? snapshot =
        await _cart.cart.doc(_cart.user!.uid).collection("products").get();
    if (snapshot.isNull) {
      return null;
    }
    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>?;

      if (data != null && !_newList.contains(data)) {
        _newList.add(data);
        cartList = _newList;
        notifyListeners();
      }
      cartTotal += data?["total"] ?? 0.0;
      saving += ((data?["comparedPrice"] ?? 0.0) - (data?["price"] ?? 0.0) > 0)
          ? (data?["comparedPrice"] ?? 0.0) - (data?["price"] ?? 0.0)
          : 0.0;
    }

    subTotal = cartTotal;
    cartQty = snapshot.size;
    this.snapshot = snapshot; // Assign the local variable to the class property
    this.saving = saving;
    notifyListeners();

    return cartTotal;
  }

  void getDistance(double distance) {
    this.distance = distance;
    notifyListeners();
  }

  void getPaymentMethod(int index) {
    if (index == 0) {
      cod = false;
    } else {
      cod = true;
    }
    notifyListeners();
  }

  Future<void> getShopName() async {
    DocumentSnapshot doc = await _cart.cart.doc(_cart.user!.uid).get();
    if (doc.exists) {
      document = doc;
    } else {
      document = null;
    }
    notifyListeners();
  }
}


*/










/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/services/cart_services.dart';

class CartProvider with ChangeNotifier {
  final CartServices _cart = CartServices();
  double subTotal = 0.0;
  int cartQty = 0;
  QuerySnapshot snapshot;
  DocumentSnapshot document;
  double saving = 0.0;
  double distance = 0.0;
  bool cod = false;
  List cartList = [];

  Future<double> getCartTotal() async {
    var cartTotal = 0.0;
    var saving = 0.0;
    List _newList = [];
    QuerySnapshot snapshot =
        await _cart.cart.doc(_cart.user!.uid).collection("products").get();
    if (snapshot == null) {
      return null;
    }
    for (var doc in snapshot.docs) {
      if(!_newList.contains(doc.data())){
        _newList.add(doc.data());
        cartList = _newList;
        notifyListeners();
      }
      cartTotal = cartTotal + doc.data()["total"];
      saving = saving + ((doc.data()["comparedPrice"] - doc.data()["price"])>0 
      ? doc.data()["comparedPrice"] - doc.data()["price"] : 0);
    }

    subTotal = cartTotal;
    cartQty = snapshot.size;
    snapshot = snapshot;
    saving = saving;
    notifyListeners();

    return cartTotal;
  }

  getDistance(distance){
     this.distance = distance;
     notifyListeners();
  }

  getPaymentMethod(index){
    if(index == 0){
      cod = false;
      notifyListeners();
    } else {
      cod = true;
      notifyListeners();
    }
  }


  getShopName() async {
    DocumentSnapshot doc = await _cart.cart.doc(_cart.user!.uid).get();
    if(doc.exists){
      document = doc;
      notifyListeners();
    } else {
      document = null;
      notifyListeners();
    }
  }
}*/
