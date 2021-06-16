import 'package:cloud_firestore/cloud_firestore.dart';

class GoryModel {
  String _gory;

  GoryModel([
    this._gory,
  ]);
  String get gory => _gory;

  set gory(String newGory) => this._gory = newGory;

  GoryModel.catSnapShot(QueryDocumentSnapshot snapshot) {
    Map map = snapshot.data();
    _gory = map['Category'];
  }
}