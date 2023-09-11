import 'package:flutter/material.dart';
import 'package:kiranjaapp_client/screens/main_screen.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  static const String id = "login-screen";

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _validPhoneNumber = false;
  final _phoneNumberController = TextEditingController();
  bool _isVerifying = false;
  bool _isVerified = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: auth.error == "Invalid OTP",
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          auth.error,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                const Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Enter your phone number to proceed",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: const InputDecoration(
                    prefixText: "+255",
                    labelText: "9 digits mobile number",
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  controller: _phoneNumberController,
                  onChanged: (value) {
                    setState(() {
                      _validPhoneNumber = value.length == 9;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AbsorbPointer(
                        absorbing:
                            !_validPhoneNumber || _isVerifying || _isVerified,
                        child: TextButton(
                          onPressed: () async {
                            if (_validPhoneNumber) {
                              setState(() {
                                auth.loading = true;
                                auth.screen = "MainScreen";
                                _isVerifying = true;
                                // start verification process
                              });

                              String number =
                                  "+255${_phoneNumberController.text}";
                              try {
                                auth.verifyPhone(
                                    context: context, number: number);

                                // verification sccessiful
                                _phoneNumberController.clear();
                                setState(() {
                                  auth.loading = false;
                                  _isVerifying = false;
                                  _isVerified = true;
                                });

                                // navigate to the desired screen
                                Navigator.pushReplacementNamed(
                                    context, MainScreen.id);
                              } catch (error) {
                                print("Error during Login: $error");
                                setState(() {
                                  auth.loading = false;
                                  _isVerifying = false;
                                });
                              }
                            }
                          },
                          child: auth.loading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                  _validPhoneNumber
                                      ? "CONTINUE"
                                      : "ENTER PHONE NUMBER",
                                  style: const TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
