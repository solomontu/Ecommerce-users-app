import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecom/models/cartModel.dart';
import 'package:flutter_ecom/models/favoriteModel.dart';
import 'package:flutter_ecom/view/common/userId.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ecom/models/productModel.dart';

final cartFavoriteProvider =
    Provider.autoDispose((ref) => CartFavoriteServices());

class CartFavoriteServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<ProductModel>> cartContentStream;
  bool result;

  //GET FROM CART
  Stream<List<CartModel>> getFromcart({String userId}) {
    return _firestore
        .collection("Carts")
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => CartModel.fromSnapShot(e)).toList());
  }

  //CHECK IF CART ITEM EXIST
  Future<List<CartModel>> cartItemExist({String userId}) async {
    List<CartModel> cartModel = [];
    await _firestore
        .collection("Carts")
        .where('userId', isEqualTo: userId)
        .get()
        .then((value) {
      for (var item in value.docs) {
        cartModel.add(CartModel.fromSnapShot(item));
      }
    });
    return cartModel;
  }

  //GET FROM favorite
  Stream<List<FavoriteModel>> getFromFavorite({String userId}) {
    return _firestore
        .collection("Favorite")
        .where('userId', isEqualTo: userId)
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

//CHECK IF FAVORITE IS AVAIBALBLE
  favoriteItemExist({String proId, String userId}) async {
    await _firestore
        .collection("Favorite")
        .where('userId', isEqualTo: userId)
        .get()
        .then((value) {
      for (var item in value.docs) {
        List<String> list = [];
        list.add(FavoriteModel.categoryFromSnapShot(item).productId);
        if (list.contains(proId) == true) {
          result = true;
        } else {
          result = false;
        }
      }
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
        .then((value) => print("Price Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
