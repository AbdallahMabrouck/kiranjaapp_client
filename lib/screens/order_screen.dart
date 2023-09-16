/*import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kiranjaapp_client/services/order_services.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrderServices _orderServices = OrderServices();
  User? user = FirebaseAuth.instance.currentUser;

  int tag = 0;
  List<String> options = [
    "All Orders",
    "Ordered",
    "Accepted",
    "Picked Up",
    "On the Way",
    "Delivered"
  ];

  @override
  Widget build(BuildContext context) {
    var _orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("My Orders", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.search, color: Colors.white),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            width: MediaQuery.of(context).size.width,
            child: ChipsChoice<int>.single(
              choiceStyle: const C2ChipStyle(
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              value: tag,
              onChanged: (val) {
                if (val == 0) {
                  setState(() {
                    _orderProvider.status = "";
                  });
                }
                setState(() {
                  tag = val;
                  if (val == 0) {
                    _orderProvider.status = options[val];
                  }
                });
              },
              choiceItems: C2Choice.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
            ),
          ),
          Container(
            child: StreamBuilder(
              stream: _orderServices.orders
                  .where("userId", isEqualTo: user!.uid)
                  .where("orderStatus",
                      isEqualTo: tag > 0 ? _orderProvider.status : null)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.data!.size == 0) {
                  return Center(
                    child: Text(tag > 0
                        ? "No ${options[tag]} orders"
                        : "No Orders. Continue shopping."),
                  );
                }

                return Expanded(
                  child: ListView(
                    children: [
                      ...snapshot.data!.docs.map((DocumentSnapshot document) {
                        final Map<String, dynamic> documentData =
                            document.data() as Map<String, dynamic>;

                        return Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              ListTile(
                                horizontalTitleGap: 0,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 14,
                                  child: _orderServices.statusIcon(document),
                                ),
                                title: Text(
                                  documentData["orderStatus"],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _orderServices.statusColor(document),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "On ${DateFormat.yMMMd().format(DateTime.parse(documentData["timestamp"]))}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Payment Type : ${documentData["cod"] == true ? "Cash on Delivery" : "Paid Online"}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Amount : \$${documentData["total"].toStringAsFixed(0)}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (documentData["deliveryBoy"]["name"].length >
                                  2)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: ListTile(
                                      tileColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.2),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Image.network(
                                          documentData["deliveryBoy"]["image"],
                                          height: 24,
                                        ),
                                      ),
                                      title: Text(
                                        documentData["deliveryBoy"]["name"],
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      subtitle: Text(
                                        _orderServices.statusComment(document),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                              ExpansionTile(
                                title: const Text(
                                  "Order details",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                                subtitle: const Text(
                                  "View order details",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Image.network(
                                              documentData["products"][index]
                                                  ["productImage"]),
                                        ),
                                        title: Text(
                                          documentData['products'][index]
                                              ["productName"],
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        subtitle: Text(
                                          "${documentData["products"][index]["qty"]} x \$${documentData["products"][index]["price"].toStringAsFixed(0)} = \$${documentData["products"][index]["total"].toStringAsFixed(0)}",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: documentData["products"].length,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12, top: 8, bottom: 8),
                                    child: Card(
                                      elevation: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "Seller : ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  documentData["seller"]
                                                      ["shopName"],
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            if (int.parse(
                                                    documentData["discount"]) >
                                                0)
                                              Container(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Discount : ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          "${documentData["discount"]}",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Discount Code: ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12),
                                                        ),
                                                        Text(
                                                          "${documentData["discountCode"]}",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Delivery Fee: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  "\$${documentData["deliveryFee"].toString()}",
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const Divider(
                                height: 3,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/