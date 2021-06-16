import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

final servicesProvider = Provider((ref) => ProductctServices());

class ProductctServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //GET FEATURED PRODUCTS IN STREAM
  Stream<List<ProductModel>> getFeaturedStream() {
    return _firestore
        .collection("Products")
        .where('featured', isEqualTo: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ProductModel.fromSnapShot(e)).toList());
  }

  // GET ONSALE PRODUCTS IN STREAM
  Stream<List<ProductModel>> getOnlseStream() {
    return _firestore
        .collection("Products")
        .where('sale', isEqualTo: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ProductModel.fromSnapShot(e)).toList());
  }

  //Get featured products
  Future<List<ProductModel>> getSimilarProducts(String category) async {
    List<ProductModel> featuredProducts = [];
    try {
      await _firestore
          .collection("Products")
          .where('category', isEqualTo: category)
          // .limitToLast(10)
          .get()
          .then((snapshot) {
        for (var item in snapshot.docs) {
          featuredProducts.add(ProductModel.fromSnapShot(item));
        }
      });
    } on Exception catch (e) {
      print(e.toString());
    }

    return featuredProducts;
  }

// //Get featured products
//   Future<List<ProductModel>> getFeaturedProducts() async {
//     List<ProductModel> featuredProducts = [];
//     try {
//       await _firestore
//           .collection(collection)
//           .where('featured', isEqualTo: true)
//           .get()
//           .then((snapshot) {
//         for (var item in snapshot.docs) {
//           featuredProducts.add(ProductModel.fromSnapShot(item));
//         }
//       });
//     } on Exception catch (e) {
//       print(e.toString());
//     }
//     return featuredProducts;
//   }

// //Get onsale products
//   Future<List<ProductModel>> getOnSaleProducts() async => await _firestore
//           .collection(collection)
//           .where('sale', isEqualTo: true)
//           .get()
//           .then((snapshot) {
//         List<ProductModel> onSaleProducts = [];
//         snapshot.docs.forEach((docsnapShot) =>
//             onSaleProducts.add(ProductModel.fromSnapShot(docsnapShot)));
//         return onSaleProducts;
//       });
}
