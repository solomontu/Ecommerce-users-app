import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ecom/controle/userServices.dart';
import 'package:flutter_ecom/models/userModel.dart';

// abstract class AuthServices {
//   signUpAuthentic();
//   signInAuthentic();
//   logOut();
// }

enum Status {
  unInitialized,
  unauthenticated,
  authenticating,
  authenticated,
  processing
}

class AuthWithEmailPassword with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Status _status = Status.unInitialized;
  UserServices _userServices = UserServices();

  FirebaseAuth _auth;
  UserModel _userModel;
  User _user;
  Status get status => _status;
  User get user => _user;
  UserModel get userModel => _userModel;

  String _error;
  String get error => _error;

  //Name consturctor of this class
  AuthWithEmailPassword.initialize() : _auth = FirebaseAuth.instance {
    _status = Status.unInitialized;
    notifyListeners();
    _auth.authStateChanges().listen((User value) async {
      // await Future.delayed(const Duration(milliseconds: 900), () {
      _status = Status.unInitialized;
      notifyListeners();
      if (value == null) {
        _status = Status.unauthenticated;
        notifyListeners();
        print('user is signed out');
      } else {
        _userModel = await _userServices.getUserByUid(id: value.uid);
        _status = Status.authenticated;
        _user = value;
        print('user signed in');
      }

      notifyListeners();
      // });
    });
  }

  //CREATE USER
  Future<bool> signUp({Map userMap}) async {
    // Call the user's CollectionReference to add a new user
    try {
      _status = Status.authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: userMap['Email'], password: userMap['Password'])
          .then((user) async {
        userMap['Uid'] = user.user.uid;
        //Create user fucntion adding userMap as an aguiment
        await _userServices.createUser(userMap);
        _userModel = await _userServices.getUserByUid(id: user.user.uid);
      });
      _error = "User Added";
      return true;
    } on FirebaseAuthException catch (e) {
      _status = Status.unInitialized;
      notifyListeners();
      if (e.code == 'weak-password') {
        _error = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        _error = 'The account already exists for that email.';
      }
      return false;
    } catch (e) {
      _status = Status.unInitialized;
      notifyListeners();
      _error = e.toString();
      return false;
    }
  }

  //SIGN IN METHOD
  // @override
  Future<bool> signInAuthentic({String emaill, String passwordd}) async {
    try {
      _status = Status.authenticating;
      notifyListeners();
      await _auth
          .signInWithEmailAndPassword(email: emaill, password: passwordd)
          .then((user) async {
        _userModel = await _userServices.getUserByUid(id: user.user.uid);
      });
      return true;
    } on FirebaseAuthException catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      if (e.code == 'user-not-found') {
        _error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        _error = 'Wrong password provided for that user.';
      }
      if (e.code == 'invalid-email') {
        _error = 'invalid email.';
      }
      return false;
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      print(e.toString);
      _error = e.toString();
      return false;
    }
  }

  // @override
  logOut() async {
    notifyListeners();
    _status = Status.processing;
    try {
      await _auth.signOut();
      notifyListeners();
      _status = Status.unauthenticated;
    } on Exception catch (e) {
      print(e);
    }
    // return false;
  }

  //what happens when the auth state changes

}
