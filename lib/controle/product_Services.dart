import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_ecom/models/productModel.dart';

class ProductctServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "Products";

//Get featured products
  Future<List<ProductModel>> getFeaturedProducts() async => await _firestore
          .collection(collection)
          .where('featured', isEqualTo: true)
          .get()
          .then((snapshot) {
        List<ProductModel> featuredProducts = [];
        snapshot.docs.forEach((docsnapShot) =>
            featuredProducts.add(ProductModel.fromSnapShot(docsnapShot)));
        return featuredProducts;
      });

//Get productos
//Get featured products
  Future<List<ProductModel>> getOnSaleProducts() async => await _firestore
          .collection(collection)
          .where('sale', isEqualTo: true)
          .get()
          .then((snapshot) {
        List<ProductModel> onSaleProducts = [];
        snapshot.docs.forEach((docsnapShot) =>
            onSaleProducts.add(ProductModel.fromSnapShot(docsnapShot)));
        return onSaleProducts;
      });
}
