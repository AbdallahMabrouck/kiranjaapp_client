import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kiranjaapp_client/screens/update_profile_screen.dart';
import 'package:kiranjaapp_client/screens/welcome_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/location_provider.dart';
import 'google_map_screen.dart';

class AccountScreen extends StatelessWidget {
  static const String id = "account-screen";
  const AccountScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var userDetails = Provider.of<AuthProvider>(context);
    var locationData = Provider.of<LocationProvider>(context);
    // User? user = FirebaseAuth.instance.currentUser;
    userDetails.getuserDetails();

    Map<String, dynamic>? userData =
        userDetails.snapshot!.data() as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Kiranja",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Container(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "MY ACCOUNT",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  color: Colors.redAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: const Text(
                                "J",
                                style: TextStyle(
                                    fontSize: 50, color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    userData?["firstName"] != null &&
                                            userData?["lastName"] != null
                                        ? "${userData?["firstName"]} ${userData?["lastName"]}"
                                        : "Update Your Name",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                  if (userData?["email"] != null)
                                    Text(
                                      "${userData?["email"]}",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  const Text(
                                    "user.phoneNumber", // Replace with actual phone number
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (userData != null)
                          ListTile(
                            tileColor: Colors.white,
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                            ),
                            title: Text(userData["location"] ?? "No location"),
                            subtitle: Text(
                              userData["address"] ?? "No address",
                              maxLines: 1,
                            ),
                            trailing: SizedBox(
                              width: 80,
                              child: OutlinedButton(
                                  onPressed: () {
                                    EasyLoading.show(status: "Please wait ...");
                                    locationData
                                        .getCurrentPosition()
                                        .then((value) {
                                      if (value != null) {
                                        EasyLoading.dismiss();
                                        PersistentNavBarNavigator
                                            .pushNewScreenWithRouteSettings(
                                          context,
                                          settings: const RouteSettings(
                                              name: MapScreen.id),
                                          screen: const MapScreen(),
                                          withNavBar: false,
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.cupertino,
                                        );
                                      } else {
                                        EasyLoading.dismiss();
                                        print("Permission not allowed");
                                      }
                                    });
                                  },
                                  child: const Text(
                                    "Change",
                                    style: TextStyle(color: Colors.redAccent),
                                  )),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    right: 10.0,
                    child: IconButton(
                        onPressed: () {
                          PersistentNavBarNavigator
                              .pushNewScreenWithRouteSettings(
                            context,
                            settings:
                                const RouteSettings(name: UpdateProfile.id),
                            screen: const UpdateProfile(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                        )))
              ],
            ),
            const ListTile(
              leading: Icon(Icons.history),
              title: Text("My Orders"),
              horizontalTitleGap: 2,
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.comment_outlined),
              title: Text("My Ratings & Review"),
              horizontalTitleGap: 2,
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.notifications_none),
              title: Text("Notifications"),
              horizontalTitleGap: 2,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.power_settings_new),
              title: const Text("Logout"),
              onTap: () {
                FirebaseAuth.instance.signOut();
                PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                  context,
                  settings: const RouteSettings(name: WelcomeScreen.id),
                  screen: const WelcomeScreen(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              horizontalTitleGap: 2,
            ),
          ],
        ),
      ),
    );
  }
}
