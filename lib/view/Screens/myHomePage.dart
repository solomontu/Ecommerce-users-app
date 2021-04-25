import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/authServices.dart';
import 'package:flutter_ecom/view/common/loading.dart';
import 'package:flutter_ecom/view/homeScreenElements/drawer.dart';
import 'package:flutter_ecom/view/homeScreenElements/featured_products.dart';
import 'package:flutter_ecom/view/homeScreenElements/products.dart';
import 'package:provider/provider.dart';
import '../widgets.dart/appBar.dart';

enum Page { column, search }

class MyHomePage extends StatelessWidget {
  final String title;
  final bool loading;

  const MyHomePage({Key key, this.title, this.loading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthWithEmailPassword _user = Provider.of<AuthWithEmailPassword>(context);
    return Scaffold(
      appBar: appbar(context,
          store: 'store',
          add: 'add',
          home: 'nothome',
          search: 'search',
          cart: 'cart'),
      //Drawer
      drawer: DrawerItems(),
      body: _user.status == Status.authenticating
          ? Loadng()
          : Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  FeaturedProducts(),
                  Expanded(child: RecentProducts()),
                ],
              )),
    );
  }
}
