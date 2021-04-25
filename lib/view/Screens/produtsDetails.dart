import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/providers_services/product_provider.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/common/constants.dart';
import 'package:flutter_ecom/view/common/transparentImage.dart';
import 'package:flutter_ecom/view/homeScreenElements/products.dart';
import 'package:flutter_ecom/view/widgets.dart/appBar.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetails({Key key, this.productModel}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  TextEditingController _quantityController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  String sizeDropdownValue;
  String colorsDropdownValue;
  @override
  void initState() {
    sizeDropdownValue = null;
    colorsDropdownValue = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context,
          add: 'add',
          home: 'nothome',
          search: 'search',
          cart: 'cart',
          store: 'store'),
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
                      widget.productModel.images[0],
                    ),
                    NetworkImage(
                      widget.productModel.images[1],
                    ),
                    // NetworkImage(widget.productModel.images[2],)
                  ],
                ),
              ),
            ),
            //image widget
            // Container(
            //     padding: EdgeInsets.symmetric(vertical: 1, horizontal: 3),
            //     height: MediaQuery.of(context).size.height / 2.5,
            //     // width: 800,
            //     width: MediaQuery.of(context).size.width,
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: widget.productModel.images.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         return Center(
            //           child: Container(
            //             // height: 200,
            //             width: MediaQuery.of(context).size.width,
            //             child: GridTile(
            //               child: FadeInImage.memoryNetwork(
            //                 fit: BoxFit.contain,
            //                 placeholder: kTransparentImage,
            //                 image: widget.productModel.images[index],
            //               ),
            //             ),
            //           ),
            //         );
            //       },
            //     )),

            //CALL TO ACTION
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('${widget.productModel.name}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      Text(''),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('\$${widget.productModel.price}',
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
                              items: widget.productModel.sizes
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
                              items: widget.productModel.sizes
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
                  Container(
                    margin: EdgeInsets.all(8),
                    // color: Colors.red,
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            child: MaterialButton(
                              onPressed: () {},
                              color: kPrimaryColor,
                              child: Text(
                                'Buy now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.add_shopping_cart,
                                color: kPrimaryColor,
                                size: 25,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.favorite_border,
                                color: kPrimaryColor,
                                size: 25,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.thumb_up_outlined,
                                color: kPrimaryColor,
                                size: 25,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.thumb_down_alt_outlined,
                                color: kPrimaryColor,
                                size: 25,
                              ),
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
              child: SizedBox(
                height: 100,
                child: Text(
                    'Description:\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s  Lorem Ipsum has been the industry standard dummy text ever since the 1500s ',
                    style: TextStyle()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
