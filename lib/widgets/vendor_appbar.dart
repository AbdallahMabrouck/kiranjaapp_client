import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';

import '../providers/store_provider.dart';

class VendorAppBar extends StatelessWidget {
  const VendorAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var _store = Provider.of<StoreProvider>(context);

    mapLauncher() async {
      GeoPoint location = _store.storedetails!["location"];
      final availableMaps = await MapLauncher.installedMaps;
      await availableMaps.first.showMarker(
        coords: Coords(location.latitude, location.longitude),
        title: "${_store.storedetails!["shopName"]} is here",
      );
    }

    return SliverAppBar(
      floating: true,
      snap: true,
      iconTheme: const IconThemeData(
        color: Colors.white, // to make back button white
      ),
      expandedHeight: 260,
      flexibleSpace: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(top: 86),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(_store.storedetails!["imageUl"]),
                  ),
                ),
                child: Container(
                  color: Colors.grey.withOpacity(.7),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Text(
                          _store.storedetails!["dialog"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          _store.storedetails!["address"],
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          _store.storedetails!["email"],
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Distance : ${_store.distance}km",
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            for (int i = 0; i < 5; i++) // Rating stars
                              const Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text("(3.5)",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  // launch("tel:${_store.storedetails!["mobile"]
                                },
                                icon: Icon(Icons.phone,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  mapLauncher();
                                },
                                icon: Icon(Icons.map,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Your action here
          },
          icon: const Icon(CupertinoIcons.search),
        ),
      ],
      title: Text(
        _store.storedetails!["shopName"],
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}









/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import '../provider/store_provider.dart';

class VendorAppBar extends StatelessWidget {
  const VendorAppBar({super.key});

  @override
  Widget build(BuildContext context) {

     var _store = Provider.of<StoreProvider>(context);

     mapLauncher() async {

      GeoPoint location = _store.storedetails!["location"];
      final availableMaps = await MapLauncher.installedMaps;
      await availableMaps.first.showMarker(coords: Coords(location.latitude, location.longitude),
      title: "{$_store.storedetails["shopName"]} is here"
      );
     }

    return SliverAppBar(
      floating: true, 
      snap: true,
      iconTheme: const IconThemeData(
            color: Colors.white
           // to make back button white
         ),
         expandedHeight: 260,
         flexibleSpace: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 86),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(_store.storedetails!["imageUtl"],),),
                  ),
                  child: Container(
                    color: Colors.grey.withOpacity(.7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Text(_store.storedetails!["dialog"], 
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                          Text(_store.storedetails!["address"], style: const TextStyle(color: Colors.white), ),
                          Text(_store.storedetails!["email"], style: const TextStyle(color: Colors.white), ),
                          Text("Distance : ${_store.distance}km", style: const TextStyle(color: Colors.white), 
                          ),
                          const SizedBox(height: 6,),
                          const Row(
                            children: [
                              Icon(Icons.star, color: Colors.white,), 
                              Icon(Icons.star, color: Colors.white,), 
                              Icon(Icons.star, color: Colors.white,),
                              Icon(Icons.star_half, color: Colors.white,),  
                              Icon(Icons.star_outline, color: Colors.white,), 
                              SizedBox(width: 5,), 
                              Text("(3.5)", style: TextStyle(color: Colors.white),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    lauch("tel:${_store.storedetails!["mobile]}");
                                  },
                                  icon: Icon(Icons.phone, color: Theme.of(context).primaryColor,),
                                ),
                              ), 
                              const SizedBox(width: 3,), 
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    mapLauncher();
                                  },
                                  icon: Icon(Icons.map, color: Theme.of(context).primaryColor,),
                                ),
                              ), 
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
      actions: [
       IconButton(
         onPressed: () {
                    
         }, 
       icon: const Icon(CupertinoIcons.search))
          ],
       title: Text(_store.storedetails!["shopName"], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
       );
  }
}*/