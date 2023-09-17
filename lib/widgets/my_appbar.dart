import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../providers/location_provider.dart';
// import '../screens/google_map_screen.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  // String _location = "";
  // String _address = "";

  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  getPrefs() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? location = prefs.getString("location");
    // String? address = prefs.getString("address");
    /*setState(() {
      _location = location!;
      _address = address!;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    // final locationData = Provider.of<LocationProvider>(context);
    return SliverAppBar(
      // making app bar scrollable
      automaticallyImplyLeading: true,
      elevation: 0.0,
      snap: true,
      floating: true,
      /*title: TextButton(
        onPressed: () {
          locationData.getCurrentPosition();
          if (locationData.permissionAllowed == true) {
            PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
              context,
              settings: const RouteSettings(name: MapScreen.id),
              screen: const MapScreen(),
              withNavBar: true,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          } else {
            print("Permission not allowed");
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    _location,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                const Icon(
                  Icons.edit_outlined,
                  color: Colors.white,
                  size: 15,
                )
              ],
            ),
            Flexible(
                child: Text(
              _address,
              // _address == null ? "press here to set Delivery Location" : _address,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ))
          ],
        ),
      ),*/
      /* actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outlined,
              color: Colors.white,
            )),
      ],*/

      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(36),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide.none),
                contentPadding: EdgeInsets.zero,
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          )),
    );
  }
}
