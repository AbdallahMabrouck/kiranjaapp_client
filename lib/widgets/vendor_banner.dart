import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/store_provider.dart';

class VendorBanner extends StatefulWidget {
  const VendorBanner({super.key});

  @override
  State<VendorBanner> createState() => _VendorBannerState();
}

class _VendorBannerState extends State<VendorBanner> {
  int _index = 0;
  int _dataLength = 1;

  @override
  void didChangeDependencies() {
    // here we can use Context
    var storeProvider = Provider.of<StoreProvider>(context);
    getBannerImageFromDb(storeProvider);

    super.didChangeDependencies();
  }

  Future getBannerImageFromDb(StoreProvider storeProvider) async {
    var fireStore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await fireStore
        .collection("vendorbanner")
        .where("sellerUid", isEqualTo: storeProvider.storedetails!["uid"])
        .get();
    if (mounted) {
      setState(() {
        _dataLength = snapshot.docs.length;
      });
    }
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    // we need to get banner only from selected vendor
    var storeProvider = Provider.of<StoreProvider>(context);
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          if (_dataLength != 0)
            FutureBuilder(
                future: getBannerImageFromDb(storeProvider),
                builder: (_, snapShot) {
                  return snapShot.data == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CarouselSlider.builder(
                              itemCount: snapShot.data.length,
                              itemBuilder: (context, int index, int realIndex) {
                                DocumentSnapshot<Map<String, dynamic>>
                                    sliderImage = snapShot.data![index];
                                Map<String, dynamic>? getImage =
                                    sliderImage.data();
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(
                                    getImage!["image"],
                                    fit: BoxFit.fill,
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                  initialPage: 0,
                                  autoPlay: true,
                                  height: 180,
                                  onPageChanged:
                                      (int i, carouselPageChangeReason) {
                                    setState(() {
                                      _index = i;
                                    });
                                  })),
                        );
                }),
          if (_dataLength != 0)
            DotsIndicator(
              dotsCount: _dataLength,
              position: _index.toDouble(),
              decorator: DotsDecorator(
                size: const Size.square(5.0),
                activeSize: const Size(18.0, 5.0),
                activeColor: Theme.of(context).primaryColor,
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
        ],
      ),
    );
  }
}
