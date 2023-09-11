import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../screens/cart_screen.dart';

class CartNotification extends StatefulWidget {
  const CartNotification({super.key});

  @override
  State<CartNotification> createState() => _CartNotificationState();
}

class _CartNotificationState extends State<CartNotification> {
  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);
    _cartProvider.getCartTotal();
    _cartProvider.getShopName();

    return Visibility(
      visible: _cartProvider.cartQty > 0 ? true : false,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12))),
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
                    Row(
                      children: [
                        Text(
                          "${_cartProvider.cartQty}${_cartProvider.cartQty == 1 ? " Item" : " Items"}",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          " | ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "\$${_cartProvider.subTotal.toStringAsFixed(0)}",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    if (_cartProvider.document != null)
                      Text(
                        "From  ${_cartProvider.document.data()["shopName"]}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    context,
                    settings: const RouteSettings(name: CartScreen.id),
                    screen: CartScreen(
                      document: _cartProvider.document,
                    ),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Container(
                  child: const Row(
                    children: [
                      Text(
                        "View Cart",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
