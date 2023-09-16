/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';

class CodToggleSwitch extends StatelessWidget {
  const CodToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    var _cart = Provider.of<CartProvider>(context);

    return Container(
      color: Colors.white,
      child: CupertinoSegmentedControl(
        borderColor: Colors.grey.shade300,
        unselectedColor: Colors.grey.shade300,
        selectedColor: Theme.of(context).primaryColor,
        children: const {
          0: Text("Pay Online"),
          1: Text("Cash on Delivery"),
        },
        onValueChanged: (int index) {
          _cart.getPaymentMethod(index);
        },
        groupValue: _cart.cod
            ? 1
            : 0, // Set the initial value based on your cart provider
      ),
    );
  }
}


*/







/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';

class CodToggleSwitch extends StatelessWidget {
  const CodToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {

    var _cart = Provider.of<CartProvider>(context);
    
    return Container(
      color: Colors.white,
      child: ToggleBar(
        backgroungColor: Colors.grey.shade300,
        textColor: Colors.grey.shade600,
        selectedTabColor: Theme.of(context).primaryColor,
        labels: ["Pay Online", "Cash on delivery"], 
        onSelectionUpdate: (index){
          _cart.getPaymentMethod(index);
        }
      ),
    );
  }
}*/