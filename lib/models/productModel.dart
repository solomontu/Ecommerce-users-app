import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class ProductModel {
  static const USERID = 'userid';
  static const PRODUCTID = 'productId';
  static const NAME = 'name';
  static const BRAND = 'brands';
  static const CATEGORY = 'category';
  static const SALE = 'sale';
  static const FEATURED = 'featured';
  static const PRICE = 'price';
  static const QTY = 'qty';
  static const SIZES = 'sizes';
  static const IMAGES = 'images';
  static const COLORS = 'colors';
  static const DETAIL = 'details';

  String _productId;
  String _userid;
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
  String _detail;

  ProductModel(
      this._name,
      this._qty,
      this._price,
      this._category,
      this._brand,
      this._detail,
      this._colors,
      this._sizes,
      this._images,
      this._featured,
      this._sale,
      this._productId,
      this._userid);

//GETTERS
  String get productId => this._productId;
  String get userid => this._userid;
  String get name => this._name;
  String get brand => this._brand;
  String get category => this._category;
  String get detail => this._detail;
  bool get sale => this._sale;
  bool get feature => this._featured;
  double get price => this._price;
  int get qty => this._qty;
  List get sizes => this._sizes;
  List get colors => this._colors;
  List get images => this._images;

  //SETTERS
  set productId(String newProductId) => this._productId = newProductId;
  set userid(String newUserId) => this._userid = newUserId;
  set name(String newName) => this._name = newName;
  set brand(String newBrand) => this._brand = newBrand;
  set category(String newCategory) => this._category = newCategory;
  set detail(String newDetial) => this._detail = newDetial;
  set sale(bool newSale) => this.sale = newSale;
  set feature(bool newFeature) => this._featured = newFeature;
  set price(double newPrice) => this._price = newPrice;
  set colors(List newColors) => this._colors = newColors;
  set sizes(List newSizes) => this._sizes = newSizes;
  set qty(int newQty) => this._qty = newQty;
  set images(List newImages) => this._images = newImages;

  // CONVERT TO MAP;
  Map<String, dynamic> toMap() {
    return {
      PRODUCTID: _productId,
      USERID: userid,
      CATEGORY: _category,
      DETAIL: _detail,
      SALE: _sale,
      NAME: _name,
      QTY: _qty,
      PRICE: _price,
      FEATURED: _featured,
      BRAND: _brand,
      COLORS: _colors,
      SIZES: _sizes,
      IMAGES: _images
    };
    // var map = Map<String, dynamic>();
    // map[ID] = _productId;
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

  ProductModel.fromSnapShot(QueryDocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _productId = data[PRODUCTID];
    _userid = data[USERID] ?? '';
    _name = data[NAME];
    _brand = data[BRAND];
    _category = data[CATEGORY];
    _detail = data[DETAIL] ?? '';
    _colors = data[COLORS];
    _sale = data[SALE];
    _featured = data[FEATURED];
    _price = data[PRICE];
    _sizes = data[SIZES];
    _qty = data[QTY];
    _images = data[IMAGES];
  }

  ProductModel.categoryFromSnapShot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    this._category = data['Categories'];
    print(_category.length);
  }

//   //FUNCTIONS
//   addColor(String color) {
//     if (_colors.contains(color) == false) {
//       _colors.add(color);
//     }
//   }

//   removeColor(String color) {
//     if (_colors.contains(color) == true) {
//       _colors.remove(color);
//     }
//   }

//   checkBoxState(String value) {
//     if (colors.contains(value)) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   //ADD SIZES
//   addSize(String size) {
//     if (_sizes.contains(size) == false) {
//       _sizes.add(size);
//     }
//   }

//   removeSize(String size) {
//     if (_sizes.contains(size) == true) {
//       _sizes.remove(size);
//     }
//   }

//   sizeCheckState(String value) {
//     if (_sizes.contains(value)) {
//       return true;
//     } else {
//       return false;
//     }
//   }

// //FEATURESTATE
//   bool featuredState() {
//     if (_featured) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   featuredAction() {
//     if (_featured) {
//       _featured = false;
//     } else {
//       _featured = true;
//     }
//   }

//   bool saleState() {
//     if (!_sale) {
//       return false;
//     } else {
//       return true;
//     }
//   }

//   saleAction() {
//     if (_sale) {
//       _sale = false;
//     } else {
//       _sale = true;
//     }
//   }

 
}
