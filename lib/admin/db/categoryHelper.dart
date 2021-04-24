import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _collationName = 'Categories';

  //GET CATETORY LIST
  Future<List<DocumentSnapshot>> getCategories() async => await _firestore
      .collection(_collationName)
      .get()
      .then((value) => value.docs);
}
