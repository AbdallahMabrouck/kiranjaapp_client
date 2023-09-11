import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/coupon_provider.dart';
import '../providers/location_provider.dart';
import '../services/cart_services.dart';
import '../services/order_services.dart';
import '../services/store_services.dart';
import '../services/user_services.dart';
import '../widgets/cart/cart_list.dart';
import '../widgets/cart/cod_toggle.dart';
import '../widgets/cart/coupon_widget.dart';
import 'account_screen.dart';
import 'google_map_screen.dart';

class CartScreen extends StatefulWidget {
  static const String id = "cart-screen";
  final DocumentSnapshot document;
  const CartScreen({super.key, required this.document});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  StoreServices _store = StoreServices();
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();
  CartServices _cartServices = CartServices();
  User? user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot? doc;
  var textStyle = const TextStyle(color: Colors.grey);
  double discount = 0;
  String _location = "";
  String _address = "";
  bool _loading = false;
  bool _checkingUser = false;
  int deliveryFee = 1000;

  @override
  void initState() {
    getPrefs();
    _store.getShopDetails(widget.document["sellerUid"]).then((value) {
      setState(() {
        doc = value;
      });
    });
    super.initState();
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? location = prefs.getString("location");
    String? address = prefs.getString("address");
    setState(() {
      _location = location!;
      _address = address!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _cartProvider = Provider.of<CartProvider>(context);
    final locationData = Provider.of<LocationProvider>(context);
    var userDetails = Provider.of<AuthProvider>(context);
    var _coupon = Provider.of<CouponProvider>(context);
    userDetails.getuserDetails().then((value) {
      double subTotal = _cartProvider.subTotal;
      double discountRate = _coupon.discountRate / 100;
      setState(() {
        discount = subTotal * discountRate;
      });
    });

    var _payable = _cartProvider.subTotal + deliveryFee - discount;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade200,
      bottomSheet: userDetails.snapshot == null
          ? Container()
          : Container(
              height: 140,
              color: Colors.blueGrey.shade900,
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Deliver to this address",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _loading = true;
                                  });
                                  locationData
                                      .getCurrentPosition()
                                      .then((value) {
                                    setState(() {
                                      _loading = false;
                                    });
                                    if (value != null) {
                                      PersistentNavBarNavigator
                                          .pushNewScreenWithRouteSettings(
                                        context,
                                        settings: const RouteSettings(
                                            name: MapScreen.id),
                                        screen: const MapScreen(),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    } else {
                                      setState(() {
                                        _loading = false;
                                      });
                                      print("Permission not allowed");
                                    }
                                  });
                                },
                                child: _loading
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        "Change",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                              )
                            ],
                          ),
                          Text(
                            userDetails.snapshot!["firstName"] != null
                                ? "${userDetails.snapshot!["firstName"]} ${userDetails.snapshot!["lastName"]} : $_location, $_address"
                                : "$_location, $_address",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "\$${_payable.toStringAsFixed(0)}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "(Including Taxes)",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 10),
                              )
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              EasyLoading.show(status: "Please wait .. ");
                              _userServices
                                  .getUserById(user!.uid)
                                  .then((value) {
                                if (value is Map<String, dynamic> &&
                                    value["userName"] == null) {
                                  EasyLoading.dismiss();
                                  // need to confirm user before placing an order
                                  PersistentNavBarNavigator
                                      .pushNewScreenWithRouteSettings(
                                    context,
                                    settings: const RouteSettings(
                                        name: AccountScreen.id),
                                    screen: const AccountScreen(),
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                } else {
                                  //  Payment gateway integration
                                  _saveOrder(_cartProvider, _payable, _coupon);
                                }
                              });
                            },
                            child: _checkingUser
                                ? const CircularProgressIndicator()
                                : const Text(
                                    "CHECKOUT",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.document["shopName"],
                      style: const TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          "${_cartProvider.cartQty}  ${_cartProvider.cartQty > 1 ? "Items, " : "Item, "}",
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        Text(
                          "To pay: \$${_payable.toStringAsFixed(0)}",
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ];
          },
          body: doc == null
              ? const Center(child: CircularProgressIndicator())
              : _cartProvider.cartQty > 0
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  ListTile(
                                    tileColor: Colors.white,
                                    leading: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.network(doc!["imageUrl"],
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    title: Text(doc!["shopName"]),
                                    subtitle: Text(doc!["address"],
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12)),
                                  ),
                                  const CodToggleSwitch(),
                                  Divider(
                                    color: Colors.grey.shade300,
                                  ),
                                ],
                              ),
                            ),
                            CartList(document: widget.document),

                            //  coupon
                            const CouponWidget(
                              couponVendor: "",
                            ),

                            //  bill details card
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 4, left: 4, top: 4, bottom: 80),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Bill Details",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              "Basket Value",
                                              style: textStyle,
                                            )),
                                            Text(
                                              "\$${_cartProvider.subTotal.toStringAsFixed(0)}",
                                              style: textStyle,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        if (discount > 0)
                                          // this will work only if discount is available
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                "Discount",
                                                style: textStyle,
                                              )),
                                              Text(
                                                "\$${discount.toStringAsFixed(0)}",
                                                style: textStyle,
                                              ),
                                            ],
                                          ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              "Delivery Fee",
                                              style: textStyle,
                                            )),
                                            Text(
                                              "\$$deliveryFee",
                                              style: textStyle,
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(
                                                child: Text(
                                              "Total Amount Payable",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            Text(
                                              "\$${_payable.toStringAsFixed(0)}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(.3),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Expanded(
                                                    child: Text(
                                                  "Total Saving",
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                )),
                                                Text(
                                                  "\$${_cartProvider.saving.toStringAsFixed(0)}",
                                                  style: const TextStyle(
                                                      color: Colors.green),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: Text("Cart is Empty, continue shopping"),
                    )),
    );
  }

  _saveOrder(CartProvider cartProvider, payable, CouponProvider coupon) {
    _orderServices.saveOrder({
      "products": cartProvider.cartList,
      "userId": user!.uid,
      "deliveryFee": deliveryFee,
      "total": payable,
      "discount": discount.toStringAsFixed(0),
      "cod": cartProvider.cod,
      "discountCode": coupon.document["title"],
      "seller": {
        "shopName": widget.document["shopName"],
        "sellerd": widget.document["selerUid"],
      },
      "timestamp": DateTime.now().toString(),
      "orderStatus": "ordered",
      "deliveryBoy": {
        "name": "",
        "phone": "",
        "location": "",
      }
    }).then((value) {
      // after submitting the order, we need to clear cart list
      _cartServices.deleteCart().then((value) {
        _cartServices.checkData().then((value) {
          EasyLoading.showSuccess("Your order is submitted");
          Navigator.pop(context);
          // close cart screen
        });
      });
    });
  }
}
