import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FirebaseService {
  CollectionReference homeBanner =
      FirebaseFirestore.instance.collection('homeBanner');
  CollectionReference brandAd =
      FirebaseFirestore.instance.collection('brandAd');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  CollectionReference mainCategories =
      FirebaseFirestore.instance.collection('mainCategories');
  CollectionReference subCategories =
      FirebaseFirestore.instance.collection('subCategories');

  String formattedNumber(number) {
    var f = NumberFormat("#, ##, ###");
    String formattedNumber = f.format(number);
    return formattedNumber;
  }
}
