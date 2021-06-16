import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String _brand ;

  BrandModel([this._brand]);

  String get brand => _brand;

  set brand(String newBrand) => this._brand = newBrand;

  BrandModel.brandSnapShot(QueryDocumentSnapshot snapshot) {
    Map map = snapshot.data();
    _brand = map['Brand'];
  }
}