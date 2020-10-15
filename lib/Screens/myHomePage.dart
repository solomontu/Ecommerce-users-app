import 'package:flutter/material.dart';
import 'package:flutter_ecom/homeScreenElements/categories.dart';
import 'package:flutter_ecom/homeScreenElements/drawer.dart';
import 'package:flutter_ecom/homeScreenElements/products.dart';

import '../appBar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.loading}) : super(key: key);

  final String title;
  final bool loading;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appbar(context, button1: 'home', button2: 'search', button3: 'cart'),
      //Drawer
      drawer: DrawerItems(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Expanded(
          child: Stack(
            children: <Widget>[
              //Carousel for homepage items
              // Flexible(child: Caroucel(),flex: 5,),
              //Categories
              //Recent products
              RecentProducts(),
              Positioned(
                child: Categories(),
                top: 0.0,
              ),
              visibility(),
            ],
          ),
        ),
      ),
    );
  }

  Widget visibility() {
    Widget loadinView;
    if (widget.loading == true) {
      loadinView = Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        color: Colors.white.withOpacity(0.7),
        child: Container(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.red),
          ),
        ),
      );
    } else {
      loadinView = Container();
    }
    return loadinView;
  }
}
