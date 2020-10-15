import 'package:flutter/material.dart';

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  List cartItems = [
    {
      'productName': "Blazer1",
      'productColor': 'balck',
      'productSize': 'M',
      'prodcutQuantity': 2,
      'oldPrice': 300,
      'newPrice': 150,
      'image': 'Assets/images/products/blazer1.jpeg'
    },
    {
      'productName': "Blazer2",
      'productColor': 'balck',
      'productSize': 'M',
      'prodcutQuantity': 2,
      'oldPrice': 790,
      'newPrice': 479.9,
      'image': 'Assets/images/products/blazer2.jpeg'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (BuildContext context, int index) {
        return SingleItem(
          name: cartItems[index]['productName'],
          color: cartItems[index]['productColor'],
          size: cartItems[index]['productSize'],
          qty: cartItems[index]['prodcutQuantity'],
          price: cartItems[index]['newPrice'],
          image: cartItems[index]['image'],
        );
      },
    );
  }
}

class SingleItem extends StatefulWidget {
  final name;
  final color;
  final size;
  final qty;
  final price;
  final image;

  const SingleItem(
      {Key key,
      this.name,
      this.color,
      this.size,
      this.qty,
      this.price,
      this.image})
      : super(key: key);

  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          //image, name, and cancel row.
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 58,
                  width: 50,
                  child: Image(image: AssetImage(widget.image)),
                ),
                Text(
                  widget.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.pink,
                    ),
                    onPressed: null),
              ],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Size',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(widget.size)
                ],
              ),
              Column(
                children: <Widget>[
                  Text('Color', style: TextStyle(color: Colors.black)),
                  Text(widget.color)
                ],
              ),
              Column(
                children: <Widget>[
                  Text('Price', style: TextStyle(color: Colors.black)),
                  Text('\$${widget.price.toString()}')
                ],
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      InkWell(
                        enableFeedback: true,
                        child: Icon(Icons.arrow_drop_up),
                        onTap: () {
                          setState(() {
                            qtyChanger('addUp');
                          });
                        },
                      ),
                      InkWell(
                        enableFeedback: true,
                        child: Icon(Icons.arrow_drop_down),
                        onTap: () {
                          setState(() {
                            qtyChanger('minus');
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Qty', style: TextStyle(color: Colors.black)),
                      Text(qty.toString())
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

//used to chnge the product quantity
  int qtyChanger(String adjustQty) {
    if (adjustQty == 'minus') {
      if (qty > 1) {
        qty = --qty;
      }
    }
    if (adjustQty == 'addUp') {
      qty = qty + 1;
    }
    return qty;
  }

 int totalPrice() {
   return  2000;
  }
}