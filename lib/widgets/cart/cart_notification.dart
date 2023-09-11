import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/services/cart_services.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';

class CartNotification extends StatefulWidget {
  const CartNotification({Key? key}) : super(key: key);

  @override
  State<CartNotification> createState() => _CartNotificationState();
}

class _CartNotificationState extends State<CartNotification> {
  final CartServices _cart = CartServices();
  DocumentSnapshot? document;

  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);
    _cartProvider.getCartTotal();
    _cart.getShopName().then((value) {
      setState(() {
        document = value;
      });
    });
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${_cartProvider.cartQty} | ${_cartProvider.cartQty == 1 ? "Item" : "Items"}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (document != null && document!.exists)
                    Text(
                      "From ${(document!.data() as Map<String, dynamic>?)?["shopName"] ?? ""}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                child: const Row(
                  children: [
                    Text(
                      "View Cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
