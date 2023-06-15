import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiranjaapp_client/screens/home_screen.dart';
import 'package:kiranjaapp_client/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const id = "splash-screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final store = GetStorage();

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      bool? boarding = store.read("onBoarding");
      boarding == null
          ? Navigator.pushReplacementNamed(context, WelcomeScreen.id)
          : boarding == true
              ? Navigator.pushReplacementNamed(context, HomeScreen.id)
              : Navigator.pushReplacementNamed(context, WelcomeScreen.id);
      Navigator.pushNamed(context, WelcomeScreen.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            Image.asset(
              "assets/images/kiranja-logo.png",
              height: 350,
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
