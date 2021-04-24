import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProviderModel {
  Uuid uuId;
  String _id;
  String _productName;
  String _imageUrl;
  List<String> _colorsList;
  List<String> _sizeList;
  List<String> _imageList;
  List<String> _categoryList;
  String _categoryValue;
  String _brandValue;
  bool _sale;
  bool _featured;
  int _quantity;
  double _price;
  bool _blueColor;
  File _image1;
  File _image2;
  File _image3;

  ProviderModel(
      [this._productName,
      this._imageUrl,
      this._quantity,
      this._price,
      this._image1,
      this._image2,
      this._image3]) {
    _colorsList = [];
    _sizeList = [];
    _imageList = [];
    _categoryValue = 'Informal';
    _brandValue = 'Gucci';
    _featured = false;
    _sale = false;
    uuId = Uuid();
    _id = uuId.v1();
  }

  String get productName => _productName;
  String get id => _id;
  String get imageUrl => _imageUrl;
  List<String> get colorList => _colorsList;
  List<String> get sizeList => _sizeList;
  String get category => _categoryValue;
  List<String> get imageList => _imageList;
  String get brand => _brandValue;
  bool get featured => _featured;
  bool get sale => _sale;
  int get quantity => _quantity;
  double get price => _price;
  bool get blueColor => _blueColor;
  File get image1 => _image1;
  File get image2 => _image2;
  File get image3 => _image3;
  List get categoryList => _categoryList;

  set productName(String newproductName) => this._productName = newproductName;

  set id(String newId) {
    this._id = newId;
  }

  set imageUrl(String newimageUrl) => this._imageUrl = newimageUrl;

  set colorList(List<String> newColors) => this._colorsList = newColors;

  set sizeList(List<String> newSizeList) => this._sizeList = newSizeList;

  set imageList(List<String> newImageList) => this._imageList = newImageList;

  set category(String newCategory) => this._categoryValue = newCategory;

  set brand(String newBrand) => this._brandValue = newBrand;

  set featured(bool newFeatured) => this._featured = newFeatured;

  set sale(bool newOnslae) => this._sale = newOnslae;

  set quantity(int newQuantity) => this._quantity = newQuantity;

  set price(double newPrice) => this._price = newPrice;

  set image1(File newImage1) => this._image1 = newImage1;

  set image2(File newImage2) => this._image2 = newImage2;

  set image3(File newImage3) => this._image3 = newImage3;

//FUNCTIONS
  addColor(String color) {
    if (_colorsList.contains(color) == false) {
      _colorsList.add(color);
    }
  }

  removeColor(String color) {
    if (_colorsList.contains(color) == true) {
      _colorsList.remove(color);
    }
  }

  checkBoxState(String value) {
    if (colorList.contains(value)) {
      return true;
    } else {
      return false;
    }
  }

  //ADD SIZES
  addSize(String size) {
    if (_sizeList.contains(size) == false) {
      _sizeList.add(size);
    }
  }

  removeSize(String size) {
    if (_sizeList.contains(size) == true) {
      _sizeList.remove(size);
    }
  }

  sizeCheckState(String value) {
    if (_sizeList.contains(value)) {
      return true;
    } else {
      return false;
    }
  }

//FEATURESTATE
  bool featuredState() {
    if (_featured) {
      return true;
    } else {
      return false;
    }
  }

  featuredAction() {
    if (_featured) {
      _featured = false;
    } else {
      _featured = true;
    }
  }

  bool saleState() {
    if (!_sale) {
      return false;
    } else {
      return true;
    }
  }

  saleAction() {
    if (_sale) {
      _sale = false;
    } else {
      _sale = true;
    }
  }

  // CONVERT TO MAP;
  Map<String, dynamic> toMap() {
    
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['featured'] = _featured;
    map['sale'] = _sale;
    map['name'] = _productName;
    map['qty'] = _quantity;
    map['price'] = _price;
    map['category'] = _categoryValue;
    map['brands'] = _brandValue;
    map['colors'] = _colorsList;
    map['sizes'] = _sizeList;
    map['images'] = _imageList;
    return map;
  }

  ProviderModel.categoryFromSnapShot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    this._categoryList = data['Categories'];
    print(_categoryList.length);
  }

  ProviderModel.brandsFromSnapShot(DocumentSnapshot snapshot) {
    this._brandValue = snapshot['Brands'];
  }
}
