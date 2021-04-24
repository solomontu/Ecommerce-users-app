import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/admin/db/brandHelper.dart';
import 'package:flutter_ecom/admin/db/categoryHelper.dart';

class BrandGoryProvider
 with ChangeNotifier {
  BrandServices _brandServices = BrandServices();
  CategoryServices _categoryServices = CategoryServices();

  List<String> _brandList = [];
  List<String> _categroyList = [];

  BrandGoryProvider
  .initialize() {
    getbrandList();
    getcategoryList();
  }
  List<String> get brandList => _brandList;
  List<String> get categoryList => _categroyList;

  getbrandList() async {
    List<DocumentSnapshot> snapshot = [];
    snapshot = await _brandServices.getBrands();
    for (int i = 0; i < snapshot.length; i++) {
      _brandList.add(snapshot[i].data()['Brand']);
    }
    snapshot.forEach((element) {
      return element.data()['brand'];
    });
    notifyListeners();
  }

  getcategoryList() async {
    List<DocumentSnapshot> snapshot = [];
    snapshot = await _categoryServices.getCategories();
    for (int i = 0; i < snapshot.length; i++) {
      _categroyList.insert(0, snapshot[i].data()['Category']);
    }
    notifyListeners();
  }

  BrandGoryProvider
  .fromsnap(QueryDocumentSnapshot snapshot) {
    List<String> _categroyList = [];
    Map map = snapshot.data();

    _categroyList.add(map['categories']);
  }
}
