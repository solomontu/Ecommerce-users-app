import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/product_Services.dart';
import 'package:flutter_ecom/models/productModel.dart';

class ProviderServices with ChangeNotifier {
  ProductctServices productctServices = ProductctServices();

  List<ProductModel> _featuredList = [];
  List<ProductModel> _onSaleList = [];

  ProviderServices.initalize() {
    _featuredProductsList();
    _onSaleProductsList();
  }

  List<ProductModel> get featuredList => _featuredList;
  List<ProductModel> get onSaleList => _onSaleList;

//Featured Provider
  void _featuredProductsList() async {
    _featuredList = await productctServices.getFeaturedProducts();
    notifyListeners();
  }

//onSale Provider
  void _onSaleProductsList() async {
    _onSaleList = await productctServices.getOnSaleProducts();
    notifyListeners();
  }
}
