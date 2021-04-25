import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecom/models/userModel.dart';

class UserServices {
  // FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // String collection = "users";
  //CREATE USERS
  CollectionReference _usersData =
      FirebaseFirestore.instance.collection('users');

//CREATE USER
  Future createUser(Map<String, dynamic> userMap) async => await _usersData
      .doc(userMap['Uid'])
      .set(userMap)
      .catchError((error) => print("Failed to add user: $error"));

  //GET USERS BY UID
  Future<UserModel> getUserByUid({String id}) async =>
      _usersData.doc(id).get().then((doc) => UserModel.fromSnapShot(doc));

  Stream<UserModel> getUserByiId({String id}) => _usersData
      .doc(id)
      .snapshots()
      .map((event) => UserModel.fromSnapShot(event));
}
