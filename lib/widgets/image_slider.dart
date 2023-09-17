import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _index = 0;
  int _dataLength = 0; // Initialize with 0

  @override
  void initState() {
    super.initState();
    getSliderImageFromDb();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getSliderImageFromDb() async {
    var fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await fireStore.collection("Slider").get();
    if (mounted) {
      setState(() {
        _dataLength = snapshot.docs.length;
      });
    }
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          if (_dataLength != 0)
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: getSliderImageFromDb(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No data available."),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: CarouselSlider.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, int index, int realIndex) {
                      DocumentSnapshot<Map<String, dynamic>> sliderImage =
                          snapshot.data!.docs[index];
                      Map<String, dynamic>? getImage = sliderImage.data();
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          getImage!["image"],
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 1,
                      initialPage: 0,
                      autoPlay: true,
                      height: 150,
                      onPageChanged: (int i, carouselPageChangeReason) {
                        setState(() {
                          _index = i;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          if (_dataLength != 0)
            DotsIndicator(
              dotsCount: _dataLength,
              position: _index.toDouble(),
              decorator: DotsDecorator(
                size: const Size.square(5.0),
                activeSize: const Size(18.0, 5.0),
                activeColor: Theme.of(context).primaryColor,
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
