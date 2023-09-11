import 'package:cloud_firestore/cloud_firestore.dart';

// for all firebase related services for user

class UserServices {
  String collection = 'users';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference vendorbanner =
      FirebaseFirestore.instance.collection("vendorbanner");

  // create new user

  Future<void> createUserData(Map<String, dynamic> values) async {
    String id = values["id"];
    await _firestore.collection(collection).doc(id).set(values);
  }

// update user data

  Future<void> updateUserData(Map<String, dynamic> values) async {
    String id = values["id"];
    await _firestore.collection(collection).doc(id).update(values);
  }

// get user data by user id

  Future<DocumentSnapshot> getUserById(String id) async {
    var result = await _firestore.collection(collection).doc(id).get();

    return result;
  }
}
