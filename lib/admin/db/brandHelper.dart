import 'package:cloud_firestore/cloud_firestore.dart';

class BrandServices {
  String _collationName = 'Brands';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

//GET BRAND
  Future<List<DocumentSnapshot>> getBrands() async => await _firestore
      .collection(_collationName)
      .get()
      .then((value) => value.docs);
}
