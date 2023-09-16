/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kiranjaapp_client/screens/welcome_screen.dart';
import '../services/user_services.dart';

class StoreProvider with ChangeNotifier {
  final UserServices _userServices = UserServices();
  User? user = FirebaseAuth.instance.currentUser;
  double userLatitude = 0.0;
  double userLongitude = 0.0;
  String selectedStore = "";
  String selectedStoreId = "";
  DocumentSnapshot? storedetails;
  String distance = "";
  String selectedProductCategory = "";
  String selectedSubCategory = "";

  getSelectedStore(storeDetails, distance) {
    storedetails = storeDetails;
    this.distance = distance;
    notifyListeners();
  }

  selectedCategory(category) {
    selectedProductCategory = category;
    notifyListeners();
  }

  selectedCategorySub(subCategory) {
    selectedSubCategory = subCategory;
    notifyListeners();
  }

  Future<void> getUserLocationData(context) async {
    _userServices.getUserById(user!.uid).then((result) {
      if (result.exists) {
        var data = result.data() as Map<String, dynamic>; // Cast to Map
        userLatitude = data["latitude"] ?? 0.0; // Use default value if null
        userLongitude = data["longitude"] ?? 0.0; // Use default value if null
        notifyListeners();
      } else {
        Navigator.pushReplacementNamed(context, WelcomeScreen.id);
      }
    });
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          "Location permissions are permanently denied, we cannot request permissions");
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw Exception(
            "Location permission is denied (actual value: $permission).");
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
*/


/*
class StoreProvider with ChangeNotifier {
  final StoreServices _storeServices = StoreServices();
  final UserServices _userServices = UserServices();
  User? user = FirebaseAuth.instance.currentUser;
  double userLatitude = 0.0; // Initialize with 0.0
  double userLongitude = 0.0; // Initialize with 0.0
  String selectedStore = "";
  String selectedStoreId = "";
  DocumentSnapshot? storedetails; // Initialize as nullable
  String distance = "";
  String selectedProductCategory = "";
  String selectedSubCategory = "";

  getSelectedStore(storeDetails, distance) {
    storedetails = storeDetails;
    this.distance = distance;
    notifyListeners();
  }

  selectedCategory(category) {
    selectedProductCategory = category;
    notifyListeners();
  }

  selectedCategorySub(subCategory) {
    selectedSubCategory = subCategory;
    notifyListeners();
  }

  Future<void> getUserLocationData(context) async {
    _userServices.getUserById(user!.uid).then((result) {
      if (result.exists) { // Check if data exists before accessing
        userLatitude = result.data()!["latitude"];
        userLongitude = result.data()!["longitude"];
        notifyListeners();
      } else {
        Navigator.pushReplacementNamed(context, WelcomeScreen.id);
      }
    });
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          "Location permissions are permanently denied, we cannot request permissions");
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw Exception(
            "Location permission is denied (actual value: $permission).");
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
*/
