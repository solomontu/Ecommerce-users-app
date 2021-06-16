import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/cartFavoServices.dart';
import 'package:flutter_ecom/models/cartModel.dart';
import 'package:flutter_ecom/models/favoriteModel.dart';
import 'package:flutter_ecom/view/Screens/favoriteBody.dart';
import 'package:flutter_ecom/view/homeScreenElements/addProduct.dart';
import 'package:flutter_ecom/view/Screens/myStore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cartBody.dart';
import '../Screens/myHomePage.dart';
import '../Screens/searchField.dart';

//CART LENGHT
StreamProvider<List<CartModel>> _cartLenght =
    StreamProvider<List<CartModel>>((ref) {
  final repository = ref.read(cartFavoriteProvider);
  return repository.getFromcart();
});

//FAVORITE LENGHT
StreamProvider<List<FavoriteModel>> _favoritemLentht =
    StreamProvider<List<FavoriteModel>>((ref) {
  final repository = ref.read(cartFavoriteProvider);
  return repository.getFromFavorite();
});

Widget appbar(
  context, {
  String add,
  String home,
  String search,
  String store,
  String cart,
  String favorite,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(50.0),
    child: AppBar(
      elevation: 0.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          iconButtonHelpa(context, home: home),
          iconButtonHelpa(context, search: search),
          iconButtonHelpa(context, add: add),
          iconButtonHelpa(context, store: store),
          iconButtonHelpa(context, favorite: favorite),
          iconButtonHelpa(context, cart: cart),
        ],
      ),
      // bottom: bottom(),
    ),
  );
}

//icons buttons helper
iconButtonHelpa(
  context, {
  String add,
  String home,
  String search,
  String cart,
  String favorite,
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
    return SizedBox();
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
    return Stack(
      children: [
        IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (contex) => CartBody()));
            }),
        Positioned(
          right: 7,
          top: 2,
          child: Consumer(
            builder: (BuildContext context, watch, Widget child) {
              AsyncValue<List<CartModel>> cartLenght = watch(_cartLenght);
              return cartLenght.when(
                data: (data) => Text(
                  data.length.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                loading: () => Container(),
                error: (err, stack) => Center(child: Text(err.toString())),
              );
            },
          ),
        )
      ],
    );
  } else if (cart == 'hcart') {
    return IconButton(
      icon: Icon(
        Icons.shopping_cart,
        color: Colors.white,
      ),
      // onPressed: () {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (contex) => CartBody()));
      // }
    );
  } else if (cart == 'notcart') {
    return SizedBox();
  }

  //button 4
  if (favorite == 'favorite') {
    return Stack(
      children: [
        IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Favorite()));
            }),
        Positioned(
          right: 7,
          top: 2,
          child: Consumer(
            builder: (BuildContext context, watch, Widget child) {
              AsyncValue<List<FavoriteModel>> favoriteLenght =
                  watch(_favoritemLentht);
              return favoriteLenght.when(
                data: (data) => Text(
                  data.length.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                loading: () => Container(),
                error: (err, stack) => Center(child: Text(err.toString())),
              );
            },
          ),
        )
      ],
    );
  } else if (favorite == 'hfavorite') {
    return IconButton(
      enableFeedback: false,
      icon: Icon(
        Icons.favorite,
        color: Colors.white,
      ),
      // onPressed: () => null
    );
  } else if (favorite == 'notfavorite') {
    return SizedBox();
  }
  //button 5
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
