import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditProfileControle {
  Future<bool> uploadProfileImage({File image, String uid}) async {
    final String pic1Name = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      TaskSnapshot task = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child(pic1Name)
          .putFile(image);
      final String downloadURL = await task.ref.getDownloadURL();
      await updateUser(downloadURL, uid);
      return true;
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateUser(String downloadUR, String uid) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      await users
          .doc(uid)
          .update({'PhotoUrl': downloadUR})
          .then((value) => print("User Updated"))
          .catchError((error) {
            print("Failed to update user: $error");
            return false;
          });
      return true;
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }
}



  // Future<void> uploadExample() async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String filePath = '${appDocDir.absolute}/file-to-upload.png';
  //   uploadFile(filePath);
  // }

  // Future<void> uploadFile(String filePath) async {
  //   File file = File(filePath);

  //   try {
  //     TaskSnapshot task1 = await firebase_storage.FirebaseStorage.instance
  //         .ref('uploads/file-to-upload.png')
  //         .putFile(file);
  //     String downLoadUrl = await task1.ref.getDownloadURL();
  //   } catch (e) {
  //     // e.g, e.code == 'canceled'
  //   }
  // }