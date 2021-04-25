import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = 'id';
  static const NAME = 'name';
  static const BRAND = 'brands';
  static const CATEGORY = 'category';
  static const SALE = 'sale';
  static const FEATURED = 'featured';
  static const PRICE = 'price';
  static const QTY = 'qty';
  static const SIZES = 'sizes';
  static const IMAGES = 'images';
  static const COLORS = 'colors.';

  String _id;
  String _name;
  String _brand;
  String _category;
  List _colors;
  List _images;
  List _sizes;
  double _price;
  bool _sale;
  bool _featured;
  int _qty;

//GETTERS
  String get id => this._id;
  String get name => this._name;
  String get brand => this._brand;
  String get category => this._category;
  bool get sale => this._sale;
  bool get feature => this._featured;
  double get price => this._price;
  int get qty => this._qty;
  List get sizes => this._sizes;
  List get colors => this._colors;
  List get images => this._images;

  //SETTERS
  set id(String newId) => this._id = newId;
  set name(String newName) => this._name = newName;
  set brand(String newBrand) => this._brand = newBrand;
  set category(String newCategory) => this._category = newCategory;
  set color(List newColors) => this._colors = _colors;
  set sale(bool newSale) => this.sale = newSale;
  set feature(bool newFeature) => this._featured = newFeature;
  set price(double newPrice) => this._price = newPrice;
  set sizes(List newSizes) => this._sizes = newSizes;
  set qty(int newQty) => this._qty = newQty;
  set images(List images) => this._images;

  // CONVERT TO MAP;
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[ID] = _id;
    map[CATEGORY] = _featured;
    map[SALE] = _sale;
    map[NAME] = _name;
    map[QTY] = _qty;
    map[PRICE] = _price;
    map[CATEGORY] = _category;
    map[BRAND] = _brand;
    map[COLORS] = _colors;
    map[SIZES] = _sizes;
    map[IMAGES] = _images;
    return map;
  }

  ProductModel.fromSnapShot(QueryDocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _id = data[ID];
    _name = data[NAME];
    _brand = data[BRAND];
    _category = data[CATEGORY];
    _colors = data[COLORS];
    _sale = data[SALE];
    _featured = data[FEATURED];
    _price = data[PRICE];
    _sizes = data[SIZES];
    _qty = data[QTY];
    _images = data[IMAGES];
  }
}
