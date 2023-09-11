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

  Future<Position?> getCurrentPosition() async {
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

      return position; // Return the Position object
    } catch (e) {
      print("Error getting current position: $e");
      return null; // Return null in case of an error
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
