import 'package:flutter/material.dart';
import 'package:flutter_ecom/appBar.dart';

import '../constants.dart';
import './products.dart';

class ProductDetails extends StatefulWidget {
  final productDetailName;
  final pridictDetailPicture;
  final productDetailNewPrice;
  final productDetailOldPrice;

  const ProductDetails(
      {Key key,
      this.productDetailName,
      this.pridictDetailPicture,
      this.productDetailNewPrice,
      this.productDetailOldPrice})
      : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    const List<String> sizeList = [
      '41',
      '42',
      '43',
      '44',
      '45',
    ];
    const List<String> colorList = ['black', 'blue', 'wine', 'pink'];
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar:
          appbar(context, button1: 'home', button2: 'search', button3: 'cart'),
      body: ListView(
        children: <Widget>[
          ProductPriceAndName(widget: widget),
          Center(
            child: Container(
              height: 35,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ProductsSpecs(fieldList: sizeList, title: 'Size'),
                      ProductsSpecs(fieldList: colorList, title: 'Color'),
                      QuantityFiled()
                    ],
                  ),
                ),
              ),
            ),
          ),
          ActionButtons(),
          Divider(),
          ProductDetailedDescription(
            productName: widget.productDetailName,
          ),
          SemilarProducts(),
        ],
      ),
    );
  }
}

class ProductPriceAndName extends StatelessWidget {
  const ProductPriceAndName({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ProductDetails widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        height: 300,
        width: 800,
        // width: MediaQuery.of(context).size.width,
        child: GridTile(
          child: Image.asset(
            widget.pridictDetailPicture,
            fit: BoxFit.contain,
          ),
          footer: Container(
              color: Colors.white70,
              child: Column(
                children: <Widget>[
                  Text(
                    ' ${widget.productDetailName}',
                    style: TextStyle(
                        // color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '\$${widget.productDetailOldPrice}',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.blueGrey,
                            fontSize: 18),
                      ),
                      Text(
                        //the actual value of this is double that made the input type different
                        '\$${widget.productDetailNewPrice}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }
}

//product dropdown buttons
class ProductsSpecs extends StatefulWidget {
  final List<String> fieldList;
  final title;

  const ProductsSpecs({
    Key key,
    @required this.fieldList,
    @required this.title,
  }) : super(key: key);

  @override
  _ProductsSpecsState createState() => _ProductsSpecsState();
}

class _ProductsSpecsState extends State<ProductsSpecs> {
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          height: 38,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      ),
                      Card(
                        child: DropdownButton(
                          value: dropdownValue,
                          iconSize: 20,
                          underline: SizedBox(),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: kDrawericonsColors,
                          ),
                          items: widget.fieldList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              dropdownValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Quantity you want to buy
class QuantityFiled extends StatelessWidget {
  final TextEditingController quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.symmetric(vertical: 1),
          // height: 30,
          width: 100,
          child: Row(
            children: <Widget>[
              Container(
                child: Text(
                  'Qty',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800),
                ),
              ),
              Expanded(
                child: Card(
                  child: TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
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
              ),
            ],
          )),
    );
  }
}

class ActionButtons extends StatefulWidget {
  @override
  _ActionButtonsState createState() => _ActionButtonsState();
}

// the action buttons for the product
class _ActionButtonsState extends State<ActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      // color: Colors.red,
      height: 50,
      width: 200,
      child: Row(
        children: <Widget>[
          Expanded(
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
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.add_shopping_cart,
                  color: kPrimaryColor,
                  size: 30,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.favorite_border,
                  color: kPrimaryColor,
                  size: 30,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

//product Detailed ProductDescription
class ProductDetailedDescription extends StatelessWidget {
  final productName;

  const ProductDetailedDescription({Key key, this.productName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8, 2.0),
          child: Text('Product detail',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
          child: Text(
            'simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
            textAlign: TextAlign.justify,
          ),
        ),
        Divider(),
        Row(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, bottom: 4, left: 8, right: 8),
              child: Text(
                'Product name: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(productName)
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Text(
                'Brand name: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text('Gucci')
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        Row(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, top: 4, left: 8, right: 8),
              child: Text(
                'Product condition: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text('Used')
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        Divider()
      ],
    );
  }
}

//semilar products
class SemilarProducts extends StatefulWidget {
  @override
  _SemilarProductsState createState() => _SemilarProductsState();
}

class _SemilarProductsState extends State<SemilarProducts> {
  RecentProducts recentProducts;

  @override
  Widget build(BuildContext context) {
    if (recentProducts == null) {
      recentProducts = RecentProducts();
    }

    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8, 2.0),
            child: Text('Semilar products',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),

          //without giving the height, the widget will throw this error
          //he getter 'visible' was called on null. Receiver: null Tried calling: visible
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recentProducts.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Hero(
                      tag: this.recentProducts.items[index]['productName'],
                      child: Material(
                        child: InkWell(
                            onTap: () {
                              // navigate back to product details page
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                            productDetailName: recentProducts
                                                .items[index]['productName'],
                                            pridictDetailPicture: recentProducts
                                                .items[index]['image'],
                                            productDetailNewPrice:
                                                recentProducts.items[index]
                                                    ['newPrice'],
                                            productDetailOldPrice:
                                                recentProducts.items[index]
                                                    ['oldPrice'],
                                          )));
                            },
                            child: Container(
                              height: 160,
                              width: 140,
                              color: Colors.white,
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  Image.asset(
                                      this.recentProducts.items[index]['image'],
                                      fit: BoxFit.contain),
                                  Positioned(
                                      bottom: 0.0,
                                      child: Container(
                                        height: 40,
                                        width: 135,
                                        color: Colors.white60,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              this.recentProducts.items[index]
                                                  ['productName'],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text(
                                                    '\$${this.recentProducts.items[index]['oldPrice'].toString()}',
                                                    // '\$$oldPrice',
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.black87),
                                                  ),
                                                  Text(
                                                    '\$${this.recentProducts.items[index]['newPrice']}',
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.w800,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            )),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
