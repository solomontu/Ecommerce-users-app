import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/cartFavoServices.dart';
import 'package:flutter_ecom/controle/cartTotalPriceService.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/common/constants.dart';
import 'package:flutter_ecom/view/common/flutterToast.dart';
import 'package:flutter_ecom/view/common/userId.dart';
import 'package:flutter_ecom/view/common/uuid.dart';

class CallToAction extends StatefulWidget {
  // const CallToAction({ Key key }) : super(key: key);
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

  const CallToAction(
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
  _CallToActionState createState() => _CallToActionState();
}

class _CallToActionState extends State<CallToAction> {
  TextEditingController _quantityController = TextEditingController();
  String sizeDropdownValue;
  String colorsDropdownValue;
  CartFavoriteServices _cartServices = CartFavoriteServices();
  CartTotalpriceService _cartTotalpriceService = CartTotalpriceService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('${widget.name}',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Text(''),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('\$${widget.price}',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text('Sizes'),
                      value: sizeDropdownValue,
                      underline: SizedBox(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: kDrawericonsColors,
                      ),
                      items:
                          widget.sizes.map<DropdownMenuItem<String>>((value) {
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text('Colours'),
                      value: colorsDropdownValue,
                      underline: SizedBox(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: kDrawericonsColors,
                      ),
                      items:
                          widget.colors.map<DropdownMenuItem<String>>((value) {
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
                        onTap: () async {
                          assert(sizeDropdownValue != null,
                              toast(msg: 'Size is required'));
                          assert(colorsDropdownValue != null,
                              toast(msg: 'Color is required'));
                          assert(_quantityController != null,
                              toast(msg: 'Quantity is required'));

                          //CHECK IF THE PRODUCT IXIST IN THE USERS CART
                          var check = await _cartServices.cartItemExist(
                              userId: getUserid());
                          bool chek1 = check.contains(widget.productId);

                          if (chek1 == true) {
                            toast(msg: '${widget.name}');
                          } else {
                            _cartServices.addToCart(
                              {
                                'productId': widget.productId,
                                'payId': uuid1,
                                'userId': getUserid(),
                                'category': widget.category,
                                'sale': widget.sale,
                                'name': widget.name,
                                'qty': int.parse(_quantityController.text),
                                'price': widget.price,
                                'cartPrice': widget.price * doub(),
                                'brands': widget.brand,
                                'colors': colorsDropdownValue,
                                'sizes': sizeDropdownValue,
                                'images': widget.images,
                              },
                            );
                            await _cartTotalpriceService.increaseCartTotal(
                                cartPrice: widget.price * doub(),
                                userId: getUserid());
                            toast(msg: 'Done');
                            ;
                          }
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
                            'featured': widget.featured,
                            'detail': widget.detail
                          },
                        )) {
                          toast(msg: 'Done');
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
                          padding: const EdgeInsets.fromLTRB(8, 1.5, 1.5, 1.5),
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
    );
  }

  double doub() {
    String contla = _quantityController.text;
    double val = double.parse(contla);
    return val;
  }
}
