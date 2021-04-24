import 'package:flutter/material.dart';
import 'package:flutter_ecom/admin/addProduct.dart';
import 'package:flutter_ecom/admin/dashBoard/dashBoard.dart';
import 'package:flutter_ecom/admin/dashBoard/overView.dart';
import 'package:flutter_ecom/view/Screens/myHomePage.dart';
import 'package:flutter_ecom/view/Screens/searchField.dart';
import 'package:flutter_ecom/view/widgets.dart/cart.dart';

class MyStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: iconButton(context),
          bottom: bottom(),
        ),
        body: TabBarView(children: [
          Overview(),
          DashBoard(),
        ]),
      ),
    );
  }
}

bottom() {
  return TabBar(indicatorColor: Colors.white,
    tabs: <Widget>[
      Tab(
        child: Text('Overview'),
      ),
      Tab(
        child: Text('Dashboard'),
      ),
    ],
  );
}

//icons buttons helper
Widget iconButton(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: IconButton(
            icon: Icon(
              Icons.add_circle_outline_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (contex) => AddProduct()));
            }),
      ),
      Expanded(
        child: IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            }),
      ),
      Expanded(
        child: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (constext) => Search()));
            }),
      ),
      Expanded(
        child: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (contex) => Cart()));
            }),
      ),
    ],
  );
}
