import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/screens/onboaard_screen.dart';
// import 'package:kiranjaapp_client/screens/register_screen.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
// import '../providers/location_provider.dart';
import 'google_map_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "Welcome";
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    bool _validPhoneNumber = false;
    var _phoneNumberController = TextEditingController();

    void showBottomSheet(context) {
      showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter myState) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: auth.error == "Invalid OTP" ? true : false,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              auth.error,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                    const Text(
                      "LOGIN",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Enter your phone number to proceed",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          prefixText: "+255",
                          labelText: "9 digits mobile number"),
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      maxLength: 9,
                      controller: _phoneNumberController,
                      onChanged: (value) {
                        if (value.length == 9) {
                          myState(() {
                            _validPhoneNumber = true;
                          });
                        } else {
                          myState(() {
                            _validPhoneNumber = false;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AbsorbPointer(
                            absorbing: _validPhoneNumber ? false : true,
                            child: ElevatedButton(
                              // color: _validPhoneNumber ? Theme.of(context).primaryColor : Colors.grey,
                              onPressed: () {
                                myState(() {
                                  auth.loading = true;
                                });
                                String number =
                                    "+255${_phoneNumberController.text}";
                                auth
                                    .verifyPhone(
                                        context: context, number: number)
                                    .then((value) {
                                  _phoneNumberController.clear();
                                  auth.loading = false;
                                });
                              },
                              child: auth.loading
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white))
                                  : Text(
                                      _validPhoneNumber
                                          ? "CONTINUE"
                                          : "ENTER PHONE NUMBER",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ).whenComplete(() {
        setState(() {
          auth.loading = false;
          _phoneNumberController.clear();
        });
      });
    }

    // final locationData = Provider.of<LocationProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Positioned(
                    right: 0.0,
                    top: 10.0,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "SKIP",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ))),
                Column(
                  children: [
                    const Expanded(child: OnBoardScreen()),
                    Text(
                      "Ready to start Selling ?",
                      style: TextStyle(color: Colors.grey.shade900),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF3F51B5))),
                      onPressed: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MapScreen()));
                      },
                      child: /*locationData.loading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const*/
                          const Text(
                        "SET YOUR LOCATION ADDRESS",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      // style: ButtonStyle(
                      // backgroundColor: MaterialStateProperty.all(
                      // const Color(0xFF3F51B5))),
                      onPressed: () {
                        setState(() {
                          auth.screen = "login";
                        });
                        showBottomSheet(context);
                      },
                      child: RichText(
                        text: TextSpan(
                            text: "Already a Customer ?  ",
                            style: TextStyle(color: Colors.grey.shade900),
                            children: const [
                              TextSpan(
                                  text: "LOGIN",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo))
                            ]),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}








/*import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/screens/register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const String id = "welcome-screen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    // final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/image11.png",
                  height: 300,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Let's get started",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Never a better time to start than now.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // custom button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.id);
                    },
                    child: const Text(
                      "Get Started",
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
