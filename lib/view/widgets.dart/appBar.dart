import 'package:flutter/material.dart';
import 'package:flutter_ecom/admin/addProduct.dart';
import 'package:flutter_ecom/admin/myStore.dart';
import 'cart.dart';
import '../Screens/myHomePage.dart';
import '../Screens/searchField.dart';

Widget appbar(
  context, {
  String add,
  String home,
  String search,
  String store,
  String cart,
}) {
  return AppBar(
    elevation: 0.0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        iconButtonHelpa(context, home: home),
        iconButtonHelpa(context, search: search),
        iconButtonHelpa(context, add: add),
        iconButtonHelpa(context, store: store),
        iconButtonHelpa(context, cart: cart),
      ],
    ),
    // bottom: bottom(),
  );
}

//icons buttons helper
iconButtonHelpa(
  context, {
  String add,
  String home,
  String search,
  String cart,
  String store,
}) {
  //button 0
  if (add == 'add') {
    return IconButton(
        icon: Icon(
          Icons.add_circle_outline_outlined,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (contex) => AddProduct()));
        });
  } else if (add == 'notadd') {
    SizedBox();
  }

  //button 1
  if (home == 'home') {
    return IconButton(
        icon: Icon(
          Icons.home,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
        });
  } else if (home == 'nothome') {
    return SizedBox();
  }

  //button 2
  if (search == 'search') {
    return IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (constext) => Search()));
        });
  } else if (search == 'notsearch') {
    return SizedBox();
  }

  //button 3
  if (cart == 'cart') {
    return IconButton(
        icon: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (contex) => Cart()));
        });
  } else if (cart == 'notcart') {
    return SizedBox();
  }

  //button 4
  if (store == 'store') {
    return IconButton(
        icon: Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyStore()));
        });
  } else if (store == 'notstore') {
    return SizedBox();
  }
}
