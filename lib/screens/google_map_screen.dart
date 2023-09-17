import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/location_provider.dart';
import 'login_screen.dart';
import 'main_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  static const String id = "map-screen";

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng currentLocation = const LatLng(-6.776012, 39.178326);
  late GoogleMapController _mapController;
  bool _locating = false;
  bool _loggedIn = false;
  User? user;

  @override
  void initState() {
    // check if user is logged on or not while opening the map
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    setState(() {
      user = FirebaseAuth.instance.currentUser;
    });

    if (user != null) {
      setState(() {
        _loggedIn = true;
      });
    }

    //  Request location permission
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);
    final _auth = Provider.of<AuthProvider>(context);

    // _checkLocationPermission();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 14.4746,
              ),
              zoomControlsEnabled: false,
              minMaxZoomPreference: const MinMaxZoomPreference(1.5, 20.8),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              mapToolbarEnabled: true,
              onCameraMove: (CameraPosition position) {
                setState(() {
                  _locating = true;
                });
                locationData.onCameraMove(position);
              },
              onMapCreated: onMapCreated,
              onCameraIdle: () {
                setState(() {
                  _locating = false;
                });
                locationData.getMoveCamera();
              },
            ),
            Center(
              child: Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 40),
                child: Image.asset(
                  "assets/images/maker.png",
                  color: Colors.black,
                ),
              ),
            ),
            if (_locating)
              const Center(
                child: SpinKitPulse(color: Colors.black54, size: 100.0),
              ),
            Positioned(
              bottom: 0.0,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_locating)
                      LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.location_searching,
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Flexible(
                          child: Text(
                            _locating
                                ? "Locating ..."
                                : locationData.selectedAddress?.locality ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        _locating
                            ? ""
                            : locationData.selectedAddress?.locality ?? "",
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: AbsorbPointer(
                          absorbing: _locating,
                          child: TextButton(
                            onPressed: () async {
                              locationData.savePrefs();
                              if (_loggedIn == false) {
                                Navigator.pushNamed(context, LogInScreen.id);
                              } else {
                                final localContext = context;
                                final updateUserResult = await _auth.updateUser(
                                  id: user!.uid,
                                  number: user!.phoneNumber,
                                );
                                setState(() {
                                  if (updateUserResult) {
                                    Navigator.pushNamed(
                                        localContext, MainScreen.id);
                                  }
                                });
                              }
                            },
                            child: const Text("CONFIRM LOCATION"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkLocationPermission() async {
    final isLocationGranted = await Permission.location.isGranted;

    if (!isLocationGranted) {
      final PermissionStatus status = await Permission.location.request();

      if (status.isDenied) {
        _showPermissionDialog();
      }
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context:
          context, // Use the context from a widget that has context available
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Required'),
          content:
              const Text('Please enable location permissions in settings.'),
          actions: [
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
