import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecom/controle/cartFavoServices.dart';
import 'package:flutter_ecom/controle/userServices.dart';
import 'package:flutter_ecom/models/cartModel.dart';
import 'package:flutter_ecom/models/favoriteModel.dart';
import 'package:flutter_ecom/models/userModel.dart';
import 'package:flutter_ecom/view/common/userId.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ecom/controle/cartTotalPriceService.dart';

enum Status {
  unInitialized,
  unauthenticated,
  authenticating,
  authenticated,
  noNetwork,
}

// = Status.unInitialized;
final authStatus =
    StateNotifierProvider.autoDispose<AuthWithEmailPassword, Status>(
        (ref) => AuthWithEmailPassword.initialize());

class AuthWithEmailPassword extends StateNotifier<Status> {
  UserServices _userServices = UserServices();
  CartFavoriteServices _cartFavoriteServices = CartFavoriteServices();
  CartTotalpriceService _cartTotalpriceServic = CartTotalpriceService();
  FirebaseAuth _auth;
  UserModel _userModel;
  Stream<List<CartModel>> _cartModel;
  Stream<List<FavoriteModel>> _favoriteModel;

  User _user;
  User get user => _user;
  UserModel get userModel => _userModel;
  Stream<List<CartModel>> get cartItems => _cartModel;
  Stream<List<FavoriteModel>> get favoriteItems => _favoriteModel;
  String _message;
  String get message => _message;

  //Name consturctor of this class
  AuthWithEmailPassword.initialize()
      : _auth = FirebaseAuth.instance,
        super(Status.unInitialized) {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      await Future.delayed(
        const Duration(milliseconds: 4000),
      );
      if (result == ConnectivityResult.none) {
        state = Status.noNetwork;
      } else {
        _auth.authStateChanges().listen((User user) async {
          if (user == null) {
            state = Status.unauthenticated;
            print('user is signed out');
          }
          if (user != null) {
            _userModel = await _userServices.getUserByUid(id: user.uid);
            _cartModel = _cartFavoriteServices.getFromcart(userId: user.uid);
            _favoriteModel =
                _cartFavoriteServices.getFromFavorite(userId: user.uid);
            _user = user;
            print('user signed in');
            state = Status.authenticated;
          }
        });
      }
    });
  }

  //CREATE USER
  Future<bool> signUp({Map userMap}) async {
    // assert(await chekNetwork() == true, state = Status.noNetwork);
    try {
      state = Status.authenticating;
      await _auth
          .createUserWithEmailAndPassword(
              email: userMap['Email'], password: userMap['Password'])
          .then((user) async {
        userMap['Uid'] = user.user.uid;
        //Create user fucntion adding userMap as an aguiment
        await _userServices.createUser(userMap).whenComplete(() async =>
            _userModel = await _userServices.getUserByUid(id: user.user.uid));
        _cartModel = _cartFavoriteServices.getFromcart(userId: user.user.uid);
        _favoriteModel =
            _cartFavoriteServices.getFromFavorite(userId: user.user.uid);
      });
      await _cartTotalpriceServic.intitialCartTotal();
      _message = "Your has account been created";
      return true;
    } on FirebaseAuthException catch (e) {
      state = Status.unauthenticated;
      _message = e.message.toString();
      return false;
    }
  }

  //SIGN IN METHOD
  // @override
  Future<bool> signInAuthentic({String emaill, String passwordd}) async {
    // assert(await chekNetwork() == true, state = Status.noNetwork);
    try {
      state = Status.authenticating;
      await _auth
          .signInWithEmailAndPassword(email: emaill, password: passwordd)
          .then((user) async {
        _userModel = await _userServices.getUserByUid(id: user.user.uid);
        _cartModel = _cartFavoriteServices.getFromcart(userId: user.user.uid);
        _favoriteModel =
            _cartFavoriteServices.getFromFavorite(userId: user.user.uid);
      });
      return true;
    } on FirebaseAuthException catch (e) {
      state = Status.unauthenticated;
      print(e.toString());
      _message = 'invalid email or password';
      return false;
    }
  }

  //GET USER AFTER UPDATE
  Future updateUser() async {
    _userModel = await _userServices.getUserByUid(id: getUserid());
    return Future;
  }

  // @override
  Future logOut() async {
    try {
      state = Status.authenticating;
      await _auth.signOut();
      await Future.delayed(Duration(milliseconds: 2000));
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return false;
    }
  }
}
