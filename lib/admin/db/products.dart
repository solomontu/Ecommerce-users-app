import 'package:cloud_firestore/cloud_firestore.dart';

class ProductServices {
  String collationName = 'Products';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future createProduct(Map<String, dynamic> map) async {
    // var id = Uuid();
    // String productId = id.v1();
    await firestore.collection(collationName).doc(map['id']).set(map);
  }
}
