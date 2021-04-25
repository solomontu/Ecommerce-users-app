import 'package:flutter/material.dart';

import 'appBar.dart';
import '../Screens/cartBody.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APP BAR
      appBar: appbar(context,
          home: 'home',
          search: 'search',
          cart: 'notcart',
          add: 'add',
          store: 'store'),
      body: CartBody(),
      //BUTTOM NAVIGATION BAR
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: ListTile(
              title: Text('Total'),
              subtitle: Text(
                '\$${2000}',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            )),
            Expanded(
              child: MaterialButton(
                color: Colors.pink,
                onPressed: () {},
                child: Text(
                  'Check Out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
