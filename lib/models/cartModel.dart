import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  static const PAYID = 'payId';
  static const USERID = 'userId';
  static const PRODUCTID = 'productId';
  static const NAME = 'name';
  static const BRAND = 'brands';
  static const CATEGORY = 'category';
  static const SALE = 'sale';
  static const PRICE = 'price';
  static const CARTPRICE = 'cartPrice';
  static const QTY = 'qty';
  static const SIZES = 'sizes';
  static const IMAGES = 'images';
  static const COLORS = 'colors';

  String _productId;
  String _payId;
  String _userId;
  String _name;
  String _brand;
  String _category;
  String _color;
  List _images;
  String _size;
  double _price;
  double _cartPrice;
  bool _sale;
  int _qty;
  CartModel([
    this._userId,
    this._payId,
    this._productId,
    this._name,
    this._brand,
    this._category,
    this._color,
    this._images,
    this._size,
    this._price,
    this._cartPrice,
    this._sale,
    this._qty,
  ]);

//GETTERS
  String get id => this._productId;
  String get payId => this._payId;
  String get userId => this._userId;
  String get name => this._name;
  String get brand => this._brand;
  String get category => this._category;
  bool get sale => this._sale;
  double get price => this._price;
  double get cartPrice => this._cartPrice;
  int get qty => this._qty;
  String get size => this._size;
  String get color => this._color;
  List get images => this._images;

  //SETTERS
  set userId(String newUserId) => this._userId = newUserId;
  set payId(String newPayId) => this._payId = newPayId;
  set productId(String newProductId) => this._productId = newProductId;
  set name(String newName) => this._name = newName;
  set brand(String newBrand) => this._brand = newBrand;
  set category(String newCategory) => this._category = newCategory;
  set sale(bool newSale) => this.sale = newSale;
  set price(double newPrice) => this._price = newPrice;
  set cartPrice(double newCartPrice) => this._cartPrice;
  set color(String newColor) => this._color = newColor;
  set sizes(String newSize) => this._size = newSize;
  set qty(int newQty) => this._qty = newQty;
  set images(List images) => this._images;

  // CONVERT TO MAP;
  Map<String, dynamic> cartModelToMap() {
    return {
      USERID: _userId,
      PAYID: _payId,
      PRODUCTID: _productId,
      CATEGORY: _category,
      SALE: _sale,
      NAME: _name,
      QTY: _qty,
      PRICE: _price,
      CARTPRICE: _cartPrice,
      BRAND: _brand,
      COLORS: _color,
      SIZES: _size,
      IMAGES: _images
    };
    // var map = Map<String, dynamic>();
    // map[ID] = _id;
    // map[FEATURED] = _featured;
    // map[SALE] = _sale;
    // map[NAME] = _name;
    // map[QTY] = _qty;
    // map[PRICE] = _price;
    // map[CATEGORY] = _category;
    // map[BRAND] = _brand;
    // map[COLORS] = _colors;
    // map[SIZES] = _sizes;
    // map[IMAGES] = _images;
    // return map;
  }

  CartModel.fromSnapShot(QueryDocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _userId = data[USERID];
    _payId = data[PAYID];
    _productId = data[PRODUCTID];
    _name = data[NAME];
    _brand = data[BRAND];
    _category = data[CATEGORY];
    _color = data[COLORS];
    _sale = data[SALE];
    _price = data[PRICE];
    _cartPrice = data[CARTPRICE];
    _size = data[SIZES];
    _qty = data[QTY];
    _images = data[IMAGES];
  }
}
