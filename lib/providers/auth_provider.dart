import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/main_screen.dart';
import '../screens/welcome_screen.dart';
import '../services/user_services.dart';
import 'location_provider.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String smsOtp;
  late String verificationId;
  String error = "";
  final UserServices _userServices = UserServices();
  bool loading = false;
  LocationProvider locationData = LocationProvider();
  String screen = "";
  double latitude = 0.0;
  double longitude = 0.0;
  String address = "";
  String location = "";

  Future<void> verifyPhone(
      {required BuildContext context, required String? number}) async {
    loading = true;
    notifyListeners();
    verificationCompleted(PhoneAuthCredential credential) async {
      loading = false;
      notifyListeners();
      await _auth.signInWithCredential(credential);
    }

    verificationFailed(FirebaseAuthException e) {
      loading = false;
      print(e.code);
      error = e.toString();
      notifyListeners();
    }

    smsOtpSend(String verId, int? resendToken) async {
      verificationId = verId;
      smsOtpDialog(context, number);
    }

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsOtpSend,
        codeAutoRetrievalTimeout: (String verificationId) {
          // You can assign the verificationId here if needed
          verificationId = verificationId;
        },
      );
    } catch (e) {
      // Handle exceptions here
      error = e.toString();
      loading = false;
      notifyListeners();
      print(e);
    }
  }

  Future<void> smsOtpDialog(BuildContext context, String? number) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Column(
            children: [
              Text("Verification Code"),
              SizedBox(
                height: 6,
              ),
              Text(
                "Enter 6 digit OTP received as SMS",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )
            ],
          ),
          content: SizedBox(
            height: 85,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 6,
              onChanged: (value) {
                smsOtp = value;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId, smsCode: smsOtp);

                  final User? user =
                      (await _auth.signInWithCredential(phoneAuthCredential))
                          .user;

                  if (user != null) {
                    loading = false;
                    notifyListeners();

                    _userServices.getUserById(user.uid).then((snapShot) {
                      if (snapShot.exists) {
                        // user data already exists
                        if (screen == "Login") {
                          Navigator.pushReplacementNamed(
                              context, MainScreen.id);
                        } else {
                          updateUser(id: user.uid, number: user.phoneNumber);
                          Navigator.pushReplacementNamed(
                              context, MainScreen.id);
                        }
                      } else {
                        _createUser(id: user.uid, number: user.phoneNumber);
                        Navigator.pushReplacementNamed(
                            context, WelcomeScreen.id);
                      }
                    });
                  } else {
                    print("login failed");
                  }
                } catch (e) {
                  error = "Invalid OTP";
                  notifyListeners();
                  print(e.toString());
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                "DONE",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        );
      },
    ).whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }

  void _createUser({required String id, required String? number}) {
    _userServices.createUserData({
      "id": id,
      "number": number,
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
      "location": location
    });
    loading = false;
    notifyListeners();
  }

  Future<bool> updateUser({required String id, required String? number}) async {
    try {
      _userServices.updateUserData({
        "id": id,
        "number": number,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "location": location,
      });
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print("Error $e");
      return false;
    }
  }
}
