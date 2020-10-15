// import 'package:firebase_database/firebase_database.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecom/Screens/signup.dart';
import 'package:flutter_ecom/Screens/singIn.dart';

abstract class AuthServices {
  signUpAuthentic();
  signInAuthentic();
}

class AuthWithEmailPassword implements AuthServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String message;
  final String email;
  final String password;
  final Map userMap;

  AuthWithEmailPassword({this.email, this.password, this.userMap});

  @override
  signUpAuthentic() async {
    // Call the user's CollectionReference to add a new user

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value.user != null) {
          await users.doc(value.user.uid).set(userMap).then((value) {
            print("Account created");
            message = 'Account created';
          }).catchError((error) {
            print("Failed to add user: $error");
            message = 'Failed to add user: $error';
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      message = e.toString();
      print(e.toString());
      SignUp(
        errorMessage: message,
      );
    }
  }

//SIGN IN METHOD
  @override
  signInAuthentic() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        message = 'Wrong password provided for that user.';
        Login(
          errorMessage: message,
        );
      }
    }
  }
}
