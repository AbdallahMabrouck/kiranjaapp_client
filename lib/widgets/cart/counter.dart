import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kiranjaapp_client/services/cart_services.dart';

class CounterForCard extends StatefulWidget {
  final DocumentSnapshot document;
  const CounterForCard({super.key, required this.document});

  @override
  State<CounterForCard> createState() => _CounterForCardState();
}

class _CounterForCardState extends State<CounterForCard> {
  User? user = FirebaseAuth.instance.currentUser;
  final CartServices _cart = CartServices();

  int _qty = 1;
  String _docId = "";
  bool _exists = false;
  bool _updating = false;

  Future<void> getCartData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("cart")
        .doc(user?.uid)
        .collection("products")
        .where("productId", isEqualTo: widget.document.get("productId"))
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        if (doc["productId"] == widget.document.get("productId")) {
          setState(() {
            _qty = doc["qty"];
            _docId = doc.id;
            _exists = true;
          });
        }
      }
    } else {
      setState(() {
        _exists = false;
      });
    }
  }

  @override
  void initState() {
    getCartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _exists
        ? Container(
            height: 28,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.pink),
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _updating = true;
                    });
                    if (_qty == 1) {
                      _cart.removeFromCart(_docId).then((value) {
                        setState(() {
                          _updating = false;
                          _exists = false;
                        });
                        _cart.checkData();
                      });
                    }
                    if (_qty > 1) {
                      setState(() {
                        _qty--;
                      });
                      var total = _qty * (widget.document["price"] as double);
                      _cart.updateCartQty(_docId, _qty, total).then((value) {
                        setState(() {
                          _updating = false;
                        });
                      });
                    }
                  },
                  child: Container(
                    child: Icon(
                      _qty == 1 ? Icons.delete_outline : Icons.remove,
                      color: Colors.pink,
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: 30,
                  color: Colors.pink,
                  child: Center(
                    child: FittedBox(
                      child: _updating
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              _qty.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _updating = true;
                      _qty++;
                    });
                    var total = _qty * (widget.document["price"] as double);
                    _cart.updateCartQty(_docId, _qty, total).then((value) {
                      setState(() {
                        _updating = false;
                      });
                    });
                  },
                  child: Container(
                    child: const Icon(
                      Icons.add,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ],
            ),
          )
        : InkWell(
            onTap: () {
              EasyLoading.show(status: "Adding to Cart");
              _cart.checkSeller().then((shopName) {
                if (shopName ==
                    (widget.document["seller"]
                        as Map<String, dynamic>)["shopName"]) {
                  setState(() {
                    _exists = true;
                  });
                  _cart.addToCart(widget.document).then((value) {
                    EasyLoading.showSuccess("Added to Cart");
                  });
                  return;
                } else {
                  if (shopName !=
                      (widget.document["seller"]
                          as Map<String, dynamic>)["shopName"]) {
                    EasyLoading.dismiss();
                    showDialog(shopName!);
                  }
                }
              });
            },
            child: Container(
              height: 28,
              decoration: BoxDecoration(
                  color: Colors.pink, borderRadius: BorderRadius.circular(4)),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
  }

  void showDialog(String shopName) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Replace Cart item?"),
          content: Text(
              "Your cart contains items from $shopName. Do you want to discard the selection and add items from ${(widget.document["seller"] as Map<String, dynamic>)["shopName"]}"),
          actions: [
            TextButton(
              onPressed: () {
                _cart.deleteCart().then((value) {
                  _cart.addToCart(widget.document).then((value) {
                    setState(() {
                      _exists = true;
                    });
                    Navigator.pop(context);
                  });
                });
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "No",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}












/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kiranjaapp_client/services/cart_services.dart';

class CounterForCard extends StatefulWidget {
  final DocumentSnapshot document;
  const CounterForCard({super.key, required this.document});

  @override
  State<CounterForCard> createState() => _CounterForCardState();
}

class _CounterForCardState extends State<CounterForCard> {
  User? user = FirebaseAuth.instance.currentUser;
  final CartServices _cart = CartServices();

  int _qty = 1;
  String _docId = "";
  bool _exists = false;
  bool _updating = false;

  getCartData() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(user?.uid)
        .collection("products")
        .where("productId", isEqualTo: widget.document.data()["productId"])
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          if (doc["productId"] == widget.document.data()["productId"]) {
            // means selected product already exists in cart, so no need to add to cart again
            setState(() {
              _qty = doc["qty"];
              _docId = doc.id;
              _exists = true;
            });
          }
        }
      } else {
        setState(() {
          _exists = false;
        });
      }
    });
  }

  @override
  void initState() {
    getCartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _exists
        ? StreamBuilder(
            stream: getCartData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Container(
                height: 28,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.pink),
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _updating = true;
                        });
                        if (_qty == 1) {
                          _cart.removeFromCart(_docId).then((value) {
                            setState(() {
                              _updating = false;
                              _exists = false;
                            });
                            // need to check after remove
                            _cart.checkData();
                          });
                        }
                        if (_qty > 1) {
                          setState(() {
                            _qty--;
                          });
                          _cart.updateCartQty(_docId, _qty).then((value) {
                            setState(() {
                              _updating = false;
                            });
                          });
                        }
                      },
                      child: Container(
                        child: Icon(
                          _qty == 1 ? Icons.delete_outline : Icons.remove,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: 30,
                      color: Colors.pink,
                      child: Center(
                          child: FittedBox(
                              child: _updating
                                  ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Text(
                                      _qty.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ))),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _updating = true;
                          _qty++;
                        });
                        _cart.updateCartQty(_docId, _qty).then((value) {
                          setState(() {
                            _updating = false;
                          });
                        });
                      },
                      child: Container(
                        child: const Icon(
                          Icons.add,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
        : StreamBuilder(
            stream: getCartData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return InkWell(
                onTap: () {
                  EasyLoading.show(status: "Adding to Cart");
                  _cart.checkSeller().then((shopName) {
                    if (shopName ==
                        widget.document.data()["seller"]["shopName"]) {
                      // product from same seller
                      setState(() {
                        _exists = true;
                      });
                      _cart.addToCart(widget.document).then((value) {
                        EasyLoading.showSuccess("Added to Cart");
                      });
                      return;
                    } else {
                      if (shopName == null) {
                        setState(() {
                          _exists = true;
                        });
                        _cart.addToCart(widget.document).then((value) {
                          EasyLoading.showSuccess("Added to Cart");
                        });
                        return;
                      }
                      if (shopName !=
                          widget.document.data()["seller"]["shopName"]) {
                        // product from different seller
                        EasyLoading.dismiss();
                        showDialog(shopName);
                      }
                    }
                  });
                },
                child: Container(
                  height: 28,
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            });
  }

  showDialog(shopName) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text("Replace Cart item?"),
            content: Text(
                "Your cart contain items from $shopName. Do you want to discard the selection and add items from ${widget.document.data()["seller"]["shopName"]}"),
            actions: [
              TextButton(
                onPressed: () {
                  // delete exixting product from cart
                  _cart.deleteCart().then((value) {
                    _cart.addToCart(widget.document).then((value) {
                      setState(() {
                        _exists = true;
                      });
                      Navigator.pop(context);
                    });
                  });
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "No",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
  }
}*/
