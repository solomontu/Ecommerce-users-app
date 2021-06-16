import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecom/models/cartModel.dart';
import 'package:flutter_ecom/models/favoriteModel.dart';
import 'package:flutter_ecom/view/common/userId.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:uuid/uuid.dart';

final cartFavoriteProvider = Provider((ref) => CartFavoriteServices());
enum AdState { loading, loaded }

class CartFavoriteServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<ProductModel>> cartContentStream;

  // AdState  = adState.loading;

  User userId;
  CartFavoriteServices({this.userId});

  //GET FROM CART
  Stream<List<CartModel>> getFromcart() {
    return _firestore
        .collection("Carts")
        .where('userId', isEqualTo: getUserid())
        .snapshots()
        .map((event) =>
            event.docs.map((e) => CartModel.fromSnapShot(e)).toList());
  }

  //GET FROM favorite
  Stream<List<FavoriteModel>> getFromFavorite() {
    return _firestore
        .collection("Favorite")
        .where('userId', isEqualTo: getUserid())
        .snapshots()
        .map((event) =>
            event.docs.map((e) => FavoriteModel.fromSnapShot(e)).toList());
  }

  //ADD TO CART
  Future addToCart(
    Map<String, dynamic> cartMap,
  ) async {
    await _firestore.collection('Carts').add(cartMap).catchError((error) {
      print(error);
    });
  }

//ADD TO FAVORITE
  addToFavorite(Map<String, dynamic> favoriteMap) async {
    try {
      await _firestore.collection('Favorite').add(favoriteMap);
      return true;
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }

//DELET FROM CART
  Future<bool> detletFromCart({String payId}) async {
    await _firestore
        .collection('Carts')
        .where('payId', isEqualTo: payId)
        .get()
        .then((value) => value.docs.first.reference.delete());

    return true;
  }

  //DELET FROM FAVORITE
  Future<bool> detletFromFavorite({String favoriteId}) async {
    await _firestore
        .collection('Favorite')
        .where('favoriteId', isEqualTo: favoriteId)
        .get()
        .then((value) => value.docs.first.reference.delete());

    // doc(favoriteId).delete();
    return true;
  }

//UPDATE CART ITEM QUANTITY
  Future<void> updateCartData({String payId, int qty, double cartPrice}) async {
    await _firestore
        .collection('Carts')
        .where('payId', isEqualTo: payId)
        .get()
        .then((value) => value.docs.first.reference
            .update({'qty': qty, 'cartPrice': cartPrice}))
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  cartTotalPrice() async {
    await _firestore
        .collection('Carts')
        .where('userId', isEqualTo: getUserid())
        .get()
        .then((value) => value.docs.forEach((element) {
              element.data();
            }));
  }
}
