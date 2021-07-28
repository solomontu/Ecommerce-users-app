import 'package:flutter/material.dart';
import 'package:flutter_ecom/view/homeScreenElements/drawer.dart';
import 'package:flutter_ecom/view/homeScreenElements/featured_products.dart';
import 'package:flutter_ecom/view/homeScreenElements/products.dart';
import 'package:flutter_ecom/view/widgets.dart/appBar.dart';

// enum Page { column, search }

class MyHomePage extends StatefulWidget {
  final String title;
  final bool loading;

  const MyHomePage({Key key, this.title, this.loading}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> homeBulider = [FeaturedProducts(), RecentProducts()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(context,
            add: 'add',
            home: 'nothome',
            search: 'search',
            cart: 'cart',
            store: 'notstore',
            favorite: 'favorite'),

        //Drawer
        drawer: DrawerItems(),
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate(
                    [FeaturedProducts(), RecentProducts()]))
          ],
        ));
  }
}
