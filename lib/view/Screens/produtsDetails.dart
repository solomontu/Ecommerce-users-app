import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/cartFavoServices.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/Screens/similarProducts.dart';
import 'package:flutter_ecom/view/common/constants.dart';
import 'package:flutter_ecom/view/common/flutterToast.dart';
import 'package:flutter_ecom/view/common/userId.dart';
import 'package:flutter_ecom/view/common/uuid.dart';
import 'package:flutter_ecom/view/widgets.dart/appBar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  final String userid;
  final String favoriteId;
  final String payId;
  final String name;
  final String brand;
  final String category;
  final String detail;
  final List colors;
  final List images;
  final List sizes;
  final double price;
  final double cartPrice;
  final bool sale;
  final bool featured;
  final int qty;
  final List<ProductModel> similarList;

  const ProductDetails(
      {Key key,
      this.productId,
      this.userid,
      this.favoriteId,
      this.payId,
      this.name,
      this.brand,
      this.category,
      this.detail,
      this.colors,
      this.images,
      this.sizes,
      this.price,
      this.cartPrice,
      this.sale,
      this.featured,
      this.qty,
      this.similarList})
      : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  TextEditingController _quantityController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  String sizeDropdownValue;
  String colorsDropdownValue;
  CartFavoriteServices _cartServices = CartFavoriteServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context,
          add: 'notadd',
          home: 'nothome',
          search: 'notsearch',
          cart: 'cart',
          store: 'notstore',
          favorite: 'favorite'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(color: Colors.white, boxShadow: [
                //   BoxShadow(offset: Offset(0, 0), blurRadius: 4.0)
                // ]),
                height: 200,
                child: Carousel(
                  // animationCurve: Curves.fastLinearToSlowEaseIn,
                  // animationDuration: Duration(milliseconds: 2000),
                  indicatorBgPadding: 6.0,
                  dotSize: 4.0,
                  dotColor: Colors.red,
                  boxFit: BoxFit.contain,
                  autoplay: false,
                  dotBgColor: Colors.transparent,
                  images: [
                    NetworkImage(
                      widget.images[0],
                    ),
                    NetworkImage(
                      widget.images[1],
                    ),
                    // NetworkImage(widget.productModel.images[2],)
                    NetworkImage(
                      widget.images[2],
                    ),
                  ],
                ),
              ),
            ),

            //CALL TO ACTION
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('${widget.name}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      Text(''),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('\$${widget.price}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      Text('')
                    ],
                  ),
                  //SPECS PREGFERENCEs
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        //Sizes dropDown buton
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text('Sizes'),
                              value: sizeDropdownValue,
                              underline: SizedBox(),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: kDrawericonsColors,
                              ),
                              items: widget.sizes
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String value) {
                                setState(() {
                                  sizeDropdownValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                        // Color dropDown buton
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text('Colours'),
                              value: colorsDropdownValue,
                              underline: SizedBox(),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: kDrawericonsColors,
                              ),
                              items: widget.colors
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String value) {
                                setState(() {
                                  colorsDropdownValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                        // QUANTITY TEX FIELD
                        Expanded(
                          child: TextFormField(
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Qty',
                              // enabledBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.red, width: 2),
                              // ),
                              // border: OutlineInputBorder(
                              //   borderSide: BorderSide(width: 2.0),
                              // ),

                              border: null,
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // SHOPPING CART
                  Container(
                    margin: EdgeInsets.all(8),
                    // color: Colors.red,
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                                onTap: () {
                                  assert(
                                      sizeDropdownValue != null,
                                      Fluttertoast.showToast(
                                          msg: 'Sellect size',
                                          backgroundColor:
                                              Theme.of(context).primaryColor));
                                  assert(
                                      colorsDropdownValue != null,
                                      Fluttertoast.showToast(
                                          msg: 'Sellect color',
                                          backgroundColor:
                                              Theme.of(context).primaryColor));
                                  assert(
                                      _quantityController != null,
                                      Fluttertoast.showToast(
                                          msg: 'Sellect Qty',
                                          backgroundColor:
                                              Theme.of(context).primaryColor));

                                  _cartServices.addToCart(
                                    {
                                      'productId': widget.productId,
                                      'payId': uuid1,
                                      'userId': getUserid(),
                                      'category': widget.category,
                                      'sale': widget.sale,
                                      'name': widget.name,
                                      'qty':
                                          int.parse(_quantityController.text),
                                      'price': widget.price,
                                      'cartPrice': widget.price * doub(),
                                      'brands': widget.brand,
                                      'colors': colorsDropdownValue,
                                      'sizes': sizeDropdownValue,
                                      'images': widget.images,
                                    },
                                  );
                                  Fluttertoast.showToast(
                                      msg: 'Added to cart',
                                      backgroundColor:
                                          Theme.of(context).primaryColor);
                                },
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: kPrimaryColor,
                                  size: 22,
                                )),

                            //FAFORITE
                            InkWell(
                              onTap: () async {
                                if (await _cartServices.addToFavorite(
                                  {
                                    'productId': widget.productId,
                                    'userId': getUserid(),
                                    'favoriteId': uuid4,
                                    'sellerid': widget.userid,
                                    'category': widget.category,
                                    'sale': widget.sale,
                                    'name': widget.name,
                                    'qty': widget.qty,
                                    'price': widget.price,
                                    'brands': widget.brand,
                                    'colors': widget.colors,
                                    'sizes': widget.sizes,
                                    'images': widget.images,
                                    'featured': widget.featured
                                  },
                                )) {
                                  toast(msg: 'Added to favorite');
                                }
                              },
                              child: Icon(
                                Icons.favorite_border,
                                color: kPrimaryColor,
                                size: 22,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8, 1.5, 1.5, 1.5),
                                  child: Icon(
                                    Icons.star_outline,
                                    color: Colors.yellow[600],
                                    size: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 1.5),
                                  child: Icon(
                                    Icons.star_outline,
                                    color: Colors.yellow[600],
                                    size: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 1.5),
                                  child: Icon(
                                    Icons.star_outline,
                                    color: Colors.yellow[600],
                                    size: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 1, vertical: 1.5),
                                  child: Icon(
                                    Icons.star_outline,
                                    color: Colors.yellow[600],
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.detail.isEmpty
                  ? SizedBox()
                  : SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.5),
                            child: Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Similar products',
                                  style: TextStyle(fontSize: 17),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            )),
                          ),
                          Text(widget.detail, style: TextStyle()),
                        ],
                      ),
                    ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.5),
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Similar products',
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.left,
                  ),
                ],
              )),
            ),
            Container(
                child: SimilarProducts(
              productModel: widget.similarList,
            )),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  double doub() {
    String contla = _quantityController.text;
    double val = double.parse(contla);
    return val;
  }
}
