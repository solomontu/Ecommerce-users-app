import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/cartFavoServices.dart';
import 'package:flutter_ecom/controle/cartTotalPriceService.dart';
import 'package:flutter_ecom/models/cartModel.dart';
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
  final Widget ifSimilarProduct;
  final Widget callToAction;

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
      this.similarList,
      this.ifSimilarProduct,
      this.callToAction})
      : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
 

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
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                child: ListBody(
                  mainAxis: Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3.0, vertical: 3),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 2.0),
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
                    SizedBox(child: widget.callToAction),

                    //PRODUCT DESCRIPOTION
                    widget.detail == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.5),
                            child: widget.detail.isEmpty
                                ? SizedBox()
                                : SizedBox(
                                    // height: 100,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Divider(),
                                        Container(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Products description',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        )),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          widget.detail,
                                          style: TextStyle(letterSpacing: 1),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                  ],
                ),
              ),
            ],
          ),
          //FROM IMAGE TO RATIN CARD

          SizedBox(child: widget.ifSimilarProduct
              //     SimilarProducts(
              //   productModel: widget.similarList,
              // )
              ),
        ],
      ),
    );
  }

 
}
