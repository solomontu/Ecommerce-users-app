import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecom/view/common/userId.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartTotalPricePrivder = Provider((ref) => CartTotalpriceService());

class CartTotalpriceService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //GET STREAM OF CART TOTAL PRICE
  Stream<double> getCartTotlPrice({String userId}) {
    return _firestore
        .collection("CartTotalPrice")
        .doc(userId)
        .snapshots()
        .map((event) => event.data()['cartTotal']);
  }

  //INCREASE  CART TOTAL PRICE
  Future<void> increaseCartTotal({String userId, double cartPrice}) async {
    double curentPrice = await getCurrentCart(userId: userId) + cartPrice;
    await _firestore
        .collection("CartTotalPrice")
        .doc(userId)
        .set({'cartTotal': curentPrice});
  }

  //DECREASE CART TOTAL PRICE
  Future deCartTotal({String userId, double cartPrice}) async {
    double curentPrice = (await getCurrentCart(userId: userId) - cartPrice);
    await _firestore
        .collection("CartTotalPrice")
        .doc(userId)
        .set({'cartTotal': curentPrice});
  }

  //GET THE CURRENT CART TOTAL PRICE
  Future<double> getCurrentCart({String userId}) async {
    return await _firestore
        .collection("CartTotalPrice")
        .doc(userId)
        .get()
        .then((value) => value.data()['cartTotal']);
  }

  Future<void> intitialCartTotal() async {
    await _firestore
        .collection("CartTotalPrice")
        .doc(getUserid())
        .set({'cartTotal': 0.00});
  }
}
