import 'package:flutter/material.dart';
import 'package:flutter_ecom/view/Screens/favoriteBody.dart';
import 'package:flutter_ecom/view/Screens/searchField.dart';
import 'package:flutter_ecom/view/homeScreenElements/addProduct.dart';
import 'package:flutter_ecom/view/homeScreenElements/drawer.dart';
import 'package:flutter_ecom/view/homeScreenElements/featured_products.dart';
import 'package:flutter_ecom/view/homeScreenElements/products.dart';
import 'package:flutter_ecom/view/widgets.dart/appBar.dart';
import 'package:flutter_ecom/view/widgets.dart/cartBody.dart';

import 'package:overlay_support/overlay_support.dart';

// enum Page { column, search }

class MyHomePage extends StatefulWidget {
  final String title;
  final bool loading;

  const MyHomePage({Key key, this.title, this.loading}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: Scaffold(
        appBar: appbar(context,
            add: 'add',
            home: 'nothome',
            search: 'search',
            cart: 'cart',
            store: 'notstore',
            favorite: 'favorite'),

        // appbar(
        //   context,
        //   store: 'notstore',
        //   add: 'add',
        //   home: 'nothome',
        //   search: 'search',
        //   favorite: 'favorite',
        //   cart: 'cart',
        // ),

        //Drawer
        drawer: DrawerItems(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  FeaturedProducts(),
                  Expanded(child: RecentProducts()),
                ],
              )),
        ),
      ),
    );
  }
}
