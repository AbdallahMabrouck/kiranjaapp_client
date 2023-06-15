import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/screens/home_screen.dart';
import 'package:kiranjaapp_client/screens/otp_screen.dart';
import 'package:kiranjaapp_client/screens/splash_screen.dart';
import 'package:kiranjaapp_client/screens/user_information_screen.dart';
import 'package:kiranjaapp_client/screens/welcome_screen.dart';

import 'screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kiranja',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        OtpScreen.id: (context) => const OtpScreen(),
        UserInfromationScreen.id: (context) => const UserInfromationScreen(),
        HomeScreen.id: (context) => const HomeScreen(index: 0),
      },
    );
  }
}
