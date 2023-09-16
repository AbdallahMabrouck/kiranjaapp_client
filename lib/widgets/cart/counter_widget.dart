/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/services/cart_services.dart';
import 'package:kiranjaapp_client/widgets/products/add_to_cart_widget.dart';

class CounterWidget extends StatefulWidget {
  final DocumentSnapshot document;
  final String docId;
  final int qty;
  const CounterWidget({
    Key? key,
    required this.document,
    required this.docId,
    required this.qty,
  }) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  final CartServices _cart = CartServices();
  late int _qty; // Make _qty non-nullable with late keyword
  bool _updating = false;
  bool _exists = true;

  @override
  void initState() {
    super.initState();
    _qty = widget.qty; // Initialize _qty in initState
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> documentData =
        widget.document.data() as Map<String, dynamic>;

    return _exists
        ? Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 56,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: FittedBox(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _updating = true;
                          });
                          if (_qty == 1) {
                            _cart.removeFromCart(widget.docId).then((value) {
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
                            var total = _qty * documentData["price"];
                            _cart
                                .updateCartQty(widget.docId, _qty, total)
                                .then((value) {
                              setState(() {
                                _updating = false;
                              });
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              _qty == 1 ? Icons.delete_outline : Icons.remove,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 8, bottom: 8),
                          child: _updating
                              ? SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor),
                                  ),
                                )
                              : Text(
                                  _qty.toString(),
                                  style: const TextStyle(color: Colors.red),
                                ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _updating = true;
                            _qty++;
                          });
                          var total = _qty * documentData["price"];
                          _cart
                              .updateCartQty(widget.docId, _qty, total)
                              .then((value) {
                            setState(() {
                              _updating = false;
                            });
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.add,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : AddToCartWidget(document: widget.document);
  }
}
*/