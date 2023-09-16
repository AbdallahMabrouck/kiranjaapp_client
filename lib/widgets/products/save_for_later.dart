/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SaveForLater extends StatelessWidget {
  final DocumentSnapshot document;
  const SaveForLater({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        EasyLoading.show(status: "Saving");
        saveForLater().then((value) {
          EasyLoading.showSuccess("Saved Successifully");
        });
      },
      child: Container(
        height: 56,
        color: Colors.grey.shade800,
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.bookmark,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Save for Later",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveForLater() {
    CollectionReference _faavorite =
        FirebaseFirestore.instance.collection("favorites");
    User? user = FirebaseAuth.instance.currentUser;
    return _faavorite.add({
      "product": document.data(),
      "customerId": user?.uid,
    });
  }
}
*/