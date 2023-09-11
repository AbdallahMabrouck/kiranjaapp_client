import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kiranjaapp_client/services/user_services.dart';

class UpdateProfile extends StatefulWidget {
  static const String id = "update-profile";

  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  final UserServices _user = UserServices();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var mobile = TextEditingController();
  var email = TextEditingController();

  updateProfile() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({
      "firstName": firstName.text,
      "lastName": lastName.text,
      "email": email.text,
    });
  }

  @override
  void initState() {
    _user.getUserById(user!.uid).then((value) {
      if (mounted) {
        final data = value.data() as Map<String, dynamic>?;

        setState(() {
          firstName.text = (data?["firstName"] ?? "").toString();
          lastName.text = (data?["lastName"] ?? "").toString();
          email.text = (data?["email"] ?? "").toString();
          mobile.text = (data?["mobile"] ?? "").toString();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Update profile",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomSheet: InkWell(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            EasyLoading.show(status: "Updating profile ... ");
            updateProfile().then((value) {
              EasyLoading.show(status: "Updated Successfully");
              Navigator.pop(context);
            });
          }
        },
        child: Container(
          width: double.infinity,
          height: 56,
          color: Colors.blueGrey.shade900,
          child: const Center(
            child: Text(
              "Update",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: firstName,
                      decoration: const InputDecoration(
                          labelText: "First Name",
                          labelStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.zero),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter first name";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: lastName,
                      decoration: const InputDecoration(
                          labelText: "Last Name",
                          labelStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.zero),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter last name";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 40,
              ),
              TextFormField(
                controller: mobile,
                enabled: false,
                decoration: const InputDecoration(
                    labelText: "Mobile",
                    labelStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.zero),
              ),
              const SizedBox(
                width: 40,
              ),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.zero),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Email Address";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
