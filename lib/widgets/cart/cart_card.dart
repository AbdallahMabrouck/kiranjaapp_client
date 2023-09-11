import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/widgets/cart/counter.dart';

class CartCard extends StatelessWidget {
  final DocumentSnapshot document;

  const CartCard({Key? key, required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    if (data == null) {
      // Handle null data here (optional)
      return const SizedBox(); // Return an empty container or any other appropriate widget
    }

    double saving = (data["comparedPrice"] ?? 0) - (data["price"] ?? 0);

    return Container(
      height: 120,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(data["productImage"] ?? '',
                        fit: BoxFit.contain),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data["productName"] ?? ''),
                      Text(data["weight"] ?? '',
                          style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 30),
                      if ((data["comparedPrice"] ?? 0) > 0)
                        Text(
                          (data["comparedPrice"] ?? 0).toString(),
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12),
                        ),
                      Text((data["price"] ?? 0).toStringAsFixed(0),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              right: 0.0,
              bottom: 0.0,
              child: CounterForCard(document: document),
            ),
            if (saving > 0)
              Positioned(
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("\$${saving.toStringAsFixed(0)}",
                              style: const TextStyle(color: Colors.white)),
                          const Text("SAVED",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}








/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/widgets/cart/counter.dart';

class CartCard extends StatelessWidget {
  final DocumentSnapshot document;
  const CartCard({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    double saving = document.data()["comparedPrice"] - document.data()["price"];

    return Container(
      height: 120, 
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300
          ),
        ),
        color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 120, 
                  width: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(document.data()["productImage"], fit: BoxFit.contain,),
                  ),
                ), 
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(document.data()["productName"],), 
                      Text(document.data()["weight"], 
                      style: const TextStyle(color: Colors.grey),), 
                      const SizedBox(height: 30,),
                      if(document.data()["comparedPrice"] >0)
                      Text(document.data()["comparedPrice"].toString(), 
                      style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 12),),
                      Text(document.data()["price"].toStringAsFixed(0), 
                      style: const TextStyle(fontWeight: FontWeight.bold),), 
                       
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              right: 0.0, bottom: 0.0,
              child: CounterForCard(document: document,),), 

              if(saving>0)
              Positioned(child: CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("\$${saving.toStringAsFixed(0)}", 
                        style: const TextStyle(color: Colors.white),),

                         const Text("SAVED", 
                        style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                ),
              ))
          ],
        ),
      ),
    );
  }
}*/