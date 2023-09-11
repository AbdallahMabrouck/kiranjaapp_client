import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider with ChangeNotifier {
  double latitude = 0.0;
  double longitude = 0.0;
  bool permissionAllowed = false;
  Placemark? selectedAddress;
  bool loading = false;

  Future<void> getCurrentPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude = position.latitude;
      longitude = position.longitude;

      final List<Placemark> address = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (address.isNotEmpty) {
        selectedAddress = address.first;
      }

      permissionAllowed = true;
      notifyListeners();
    } catch (e) {
      print("Error getting current position: $e");
    }
  }

  void onCameraMove(CameraPosition cameraPosition) {
    latitude = cameraPosition.target.latitude;
    longitude = cameraPosition.target.longitude;
    notifyListeners();
  }

  Future<void> getMoveCamera() async {
    final List<Placemark> address = await placemarkFromCoordinates(
      latitude,
      longitude,
    );
    if (address.isNotEmpty) {
      selectedAddress = address.first;
    }
    notifyListeners();
    print("${selectedAddress?.name} : ${selectedAddress?.street}");
  }

  Future<void> savePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble("latitude", latitude);
    prefs.setDouble("longitude", longitude);
    prefs.setString("address", selectedAddress?.toString() ?? "");
  }
}
