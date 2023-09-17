import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiranjaapp_client/firebase_options.dart';
import 'package:kiranjaapp_client/providers/auth_provider.dart';
// import 'package:kiranjaapp_client/providers/cart_provider.dart';
import 'package:kiranjaapp_client/providers/location_provider.dart';
import 'package:kiranjaapp_client/screens/google_map_screen.dart';
import 'package:kiranjaapp_client/screens/login_screen.dart';
import 'package:kiranjaapp_client/screens/main_screen.dart';
// import 'package:kiranjaapp_client/providers/store_provider.dart';
import 'package:kiranjaapp_client/screens/splash_screen.dart';
import 'package:kiranjaapp_client/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => LocationProvider(),
      ),
    ], child: const MyApp()),
  );

  /* MultiProvider(
    providers: [
      
      ChangeNotifierProvider(
        create: (_) => StoreProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
      ),
    ],
    child: const MyApp(),
  ));*/
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        MapScreen.id: (context) => const MapScreen(),
        LogInScreen.id: (context) => const LogInScreen(),
        MainScreen.id: (context) => const MainScreen(index: 0),
        // RegisterScreen.id: (context) => const RegisterScreen(),
        // OtpScreen.id: (context) => const OtpScreen(),
        // UserInfromationScreen.id: (context) => const UserInfromationScreen(),
        // LandingScreen.id: (context) => const LandingScreen(),
        // MainScreen.id: (context) => const MainScreen(index: 0),
        // VendorHomeScreen.id: (context) => const VendorHomeScreen(),
        // ProductListScreen.id: (context) => const ProductListScreen(),
        // NewProductDetailsScreen.id: (context) => NewProductDetailsScreen(),
        //  CartScreen.id: (context) => const CartScreen(),
        // AccountScreen.id :(context) => const AccountScreen(),
        // UpdateProfile.id :(context) => const UpdateProfile(),
      },
      builder: EasyLoading.init(),
    );
  }
}
