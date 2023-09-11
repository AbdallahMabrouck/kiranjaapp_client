import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kiranjaapp_client/services/store_services.dart';
import 'package:provider/provider.dart';

import '../../providers/store_provider.dart';

class TopPickStore extends StatefulWidget {
  const TopPickStore({super.key});

  @override
  State<TopPickStore> createState() => _TopPickStoreState();
}

class _TopPickStoreState extends State<TopPickStore> {
  final StoreServices _storeServices = StoreServices();

  @override
  Widget build(BuildContext context) {
    final _storeData = Provider.of<StoreProvider>(context);
    _storeData.getUserLocationData(context);

    String getDistance(GeoPoint location) {
      var distance = Geolocator.distanceBetween(_storeData.userLatitude,
          _storeData.userLongitude, location.latitude, location.longitude);
      var distanceInKm = distance / 1000;
      return distanceInKm.toStringAsFixed(2);
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _storeServices.geTopPickedStore(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();

        List<double> shopDistance = [];
        for (int i = 0; i < snapshot.data!.docs.length; i++) {
          double distance = Geolocator.distanceBetween(
              _storeData.userLatitude,
              _storeData.userLongitude,
              snapshot.data!.docs[i]["location"].latitude,
              snapshot.data!.docs[i]["location"].longitude);
          double distanceInKm = distance / 1000;
          shopDistance.add(distanceInKm);
        }
        shopDistance.sort();

        if (shopDistance.isNotEmpty && shopDistance[0] > 10) {
          return Container();
        }

        return Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 20),
                child: Row(
                  children: [
                    SizedBox(
                      height: 30,
                      child: Image.asset("images/like.gif"),
                    ),
                    const Text(
                      "Top Picked Stores",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    )
                  ],
                ),
              ),
              Flexible(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    double distance =
                        double.parse(getDistance(document["location"]));
                    if (distance < 10) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: Card(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      document["imageUrl"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35,
                                child: Text(
                                  document["shopName"],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                "${distance.toStringAsFixed(2)}Km",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }).toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
