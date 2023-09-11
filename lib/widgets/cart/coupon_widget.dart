import 'dart:js_interop';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../providers/coupon_provider.dart';

class CouponWidget extends StatefulWidget {
  final String couponVendor;
  const CouponWidget({Key? key, required this.couponVendor}) : super(key: key);

  @override
  State<CouponWidget> createState() => _CouponWidgetState();
}

class _CouponWidgetState extends State<CouponWidget> {
  Color color = Colors.grey;
  bool _enable = false;
  bool _visible = false;

  final _couponText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _coupon = Provider.of<CouponProvider>(context);

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 38,
                    child: TextField(
                      controller: _couponText,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        hintText: "Enter Voucher Code",
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      onChanged: (String value) {
                        if (value.length < 3) {
                          setState(() {
                            color = Colors.grey;
                            _enable = false;
                          });
                          if (value.isNotEmpty) {
                            setState(() {
                              color = Theme.of(context).primaryColor;
                              _enable = true;
                            });
                          }
                        }
                      },
                    ),
                  ),
                ),
                AbsorbPointer(
                  absorbing: _enable ? false : true,
                  child: OutlinedButton(
                    onPressed: () {
                      EasyLoading.show(status: "Validating Coupon");
                      _coupon
                          .getCouponDetails(
                              _couponText.text, widget.couponVendor)
                          .then((value) {
                        if (_coupon.document.isNull) {
                          setState(() {
                            _coupon.discountRate = 0;
                            _visible = false;
                          });
                          EasyLoading.dismiss();
                          showDialog("Not valid");
                          return;
                        }
                        if (_coupon.expired == false) {
                          // not expired, coupon is valid
                          setState(() {
                            _visible = true;
                          });
                          EasyLoading.dismiss();
                          return;
                        }
                        if (_coupon.expired == true) {
                          setState(() {
                            _coupon.discountRate = 0;
                            _visible = false;
                          });
                          EasyLoading.dismiss();
                          showDialog("Expired");
                        }
                      });
                    },
                    child: const Text("Apply"),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: _visible,
            child: _coupon.document.isNull
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DottedBorder(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.deepOrangeAccent.withOpacity(.4),
                              ),
                              width: MediaQuery.of(context).size.width - 80,
                              height: 60,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child:
                                        Text(_coupon.document!["title"] ?? ""),
                                  ),
                                  Divider(
                                    color: Colors.grey.shade800,
                                  ),
                                  Text(_coupon.document!["details"] ?? ""),
                                  Text(
                                      "${_coupon.document!["discountRate"]}% discount on Total purchase"),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              right: -5.0,
                              top: -10,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _coupon.discountRate = 0;
                                      _visible = false;
                                      _couponText.clear();
                                    });
                                  },
                                  icon: const Icon(Icons.clear)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  showDialog(validity) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("APPLY COUPON"),
          content: Text(
              "This discount coupon you have entered is $validity. Please try with another code"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "OK",
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
