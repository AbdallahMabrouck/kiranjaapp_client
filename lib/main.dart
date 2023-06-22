import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiranjaapp_client/firebase_options.dart';
import 'package:kiranjaapp_client/screens/main_screen.dart';
import 'package:kiranjaapp_client/screens/otp_screen.dart';
import 'package:kiranjaapp_client/screens/splash_screen.dart';
import 'package:kiranjaapp_client/screens/user_information_screen.dart';
import 'package:kiranjaapp_client/screens/welcome_screen.dart';

import 'screens/register_screen.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kiranja',
      color: Colors.blue,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        OtpScreen.id: (context) => const OtpScreen(),
        UserInfromationScreen.id: (context) => const UserInfromationScreen(),
        MainScreen.id: (context) => const MainScreen(index: 0)
      },
    );
  }
}
