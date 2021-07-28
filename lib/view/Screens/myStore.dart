import 'package:flutter/material.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/homeScreenElements/addProduct.dart';
import 'package:flutter_ecom/admin/dashBoard/dashBoard.dart';
import 'package:flutter_ecom/admin/dashBoard/overView.dart';
import 'package:flutter_ecom/view/Screens/myHomePage.dart';
import 'package:flutter_ecom/view/Screens/searchField.dart';

class MyStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                title: Text('My Store'),
                bottom: bottom(),
              )
            ];
          },
          body: TabBarView(children: [
            Overview(),
            DashBoard(),
          ]),
        ));
  }
}

bottom() {
  return TabBar(
    indicatorColor: Colors.white,
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
              Icons.add_circle_outline_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (contex) => AddProduct()));
            }),
      ),
    ],
  );
}
