import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecom/controle/userServices.dart';
import 'package:flutter_ecom/models/userModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Status {
  unInitialized,
  unauthenticated,
  authenticating,
  authenticated,
  noAccount,
  noNetwork
}

// = Status.unInitialized;
final authStatus = StateNotifierProvider<AuthWithEmailPassword, Status>(
    (ref) => AuthWithEmailPassword.initialize());

class AuthWithEmailPassword extends StateNotifier<Status> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserServices _userServices = UserServices();
  // Status state = Status.unInitialized;

  FirebaseAuth _auth;
  Connectivity connect;
  UserModel _userModel;
  User _user;
  bool netwoka;
  // Status get status => _status;
  User get user => _user;
  UserModel get userModel => _userModel;
  String _error;
  String get error => _error;

  //Name consturctor of this class
  AuthWithEmailPassword.initialize()
      : _auth = FirebaseAuth.instance,
        connect = Connectivity(),
        super(Status.unInitialized) {
    connect.onConnectivityChanged.listen((event) {
      if (event != ConnectivityResult.none) {
        _auth.authStateChanges().listen((User value) async {
          await Future.delayed(
            const Duration(milliseconds: 4000),
          );
          if (value == null) {
            state = Status.unauthenticated;
            print('user is signed out');
          }
          if (value != null) {
            _userModel = await _userServices.getUserByUid(id: value.uid);
            _user = value;

            print('user signed in');
            state = Status.authenticated;
          }
        });
      } else {
        state = Status.noNetwork;
      }
    });
  }

  //CREATE USER
  Future<bool> signUp({Map userMap}) async {
    try {
      state = Status.authenticating;
      await _auth
          .createUserWithEmailAndPassword(
              email: userMap['Email'], password: userMap['Password'])
          .then((user) async {
        userMap['Uid'] = user.user.uid;
        //Create user fucntion adding userMap as an aguiment
        await _userServices.createUser(userMap);
        _userModel = await _userServices.getUserByUid(id: user.user.uid);
      });
      _error = "Your has account been created";
      return true;
    } catch (e) {
      state = Status.unauthenticated;
      _error = e.toString();
      return false;
    }
  }

  //SIGN IN METHOD
  // @override
  Future<bool> signInAuthentic({String emaill, String passwordd}) async {
    try {
      state = Status.authenticating;
      await _auth
          .signInWithEmailAndPassword(email: emaill, password: passwordd)
          .then((user) async {
        _userModel = await _userServices.getUserByUid(id: user.user.uid);
      });
      return true;
    } catch (e) {
      state = Status.unauthenticated;
      print(e.toString());
      _error = 'invalid email or password';
      return false;
    }
    // return false;
  }

  // @override
  Future<bool> logOut() async {
    try {
      state = Status.authenticating;
      await _auth.signOut();
      _userModel = null;
      return true;
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> chekNetwork() {
    return connect.checkConnectivity().then((value) {
      if (value != ConnectivityResult.none) {
        return true;
      } else {
        return false;
      }
    });
  }
}
