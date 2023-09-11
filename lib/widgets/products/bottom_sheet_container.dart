import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/widgets/products/save_for_later.dart';

import 'add_to_cart_widget.dart';

class BottomSheetContainer extends StatefulWidget {
  final DocumentSnapshot document;
  const BottomSheetContainer({super.key, required this.document});

  @override
  State<BottomSheetContainer> createState() => _BottomSheetContainerState();
}

class _BottomSheetContainerState extends State<BottomSheetContainer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            flex: 1,
            child: SaveForLater(
              document: widget.document,
            )),
        Flexible(
            flex: 1,
            child: AddToCartWidget(
              document: widget.document,
            ))
      ],
    );
  }
}
