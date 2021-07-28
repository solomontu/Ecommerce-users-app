import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/authServices.dart';
import 'package:flutter_ecom/controle/cartFavoServices.dart';
import 'package:flutter_ecom/controle/product_Services.dart';
import 'package:flutter_ecom/models/favoriteModel.dart';
import 'package:flutter_ecom/view/Screens/produtsDetails.dart';
import 'package:flutter_ecom/view/Screens/similarProducts.dart';
import 'package:flutter_ecom/view/common/callToAction.dart';
import 'package:flutter_ecom/view/common/flutterToast.dart';
import 'package:flutter_ecom/view/common/navigation.dart';
import 'package:flutter_ecom/view/common/transparentImage.dart';
import 'package:flutter_ecom/view/common/userId.dart';
import 'package:flutter_ecom/view/common/visibility.dart';
import 'package:flutter_ecom/view/widgets.dart/appBar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  CartFavoriteServices _cartFavoriteServices = CartFavoriteServices();
  ProductctServices productctServices = ProductctServices();
  bool _deleting;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(context,
            add: 'notadd',
            home: 'nothome',
            search: 'notsearch',
            cart: 'notcart',
            store: 'notstore',
            favorite: 'hfavorite'),
        body: Stack(
          fit: StackFit.expand,
          children: [
            StreamBuilder<List<FavoriteModel>>(
              stream:
                  _cartFavoriteServices.getFromFavorite(userId: getUserid()),
              builder: (BuildContext context,
                  AsyncSnapshot<List<FavoriteModel>> snapshot) {
                Widget child;
                if (snapshot.hasError) {
                  child = Center(child: Text('An erro has Occured'));
                } else {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      child = Center(child: Text('No Connection'));
                      break;
                    case ConnectionState.waiting:
                      child = Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.active:
                      child = userFavoriteBuilder(snapshot);
                      break;
                    case ConnectionState.done:
                      child = userFavoriteBuilder(snapshot);
                      break;
                  }
                }

                return child;
              },
            ),
            visibility(context: context, value: _deleting)
          ],
        ));
  }

  Widget userFavoriteBuilder(AsyncSnapshot<List<FavoriteModel>> snapshot) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Dismissible(
                  background: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.delete, color: Colors.grey),
                            Text('Move to trash',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(Icons.delete, color: Colors.grey),
                          Text('Move to trash',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  confirmDismiss: (DismissDirection direction) =>
                      _showMyDeleteDialog(context),
                  key: ValueKey<FavoriteModel>(snapshot.data[index]),
                  onDismissed: (DismissDirection direction) async {
                    setState(() {
                      _deleting = true;
                    });

                    if (await _cartFavoriteServices.detletFromFavorite(
                        favoriteId: snapshot.data[index].favoriteId)) {
                      await toast(msg: 'Deleted');
                    }
                    setState(() {
                      _deleting = false;
                    });
                  },
                  child: Card(
                    child: Hero(
                      tag: DateTime.now().millisecondsSinceEpoch.toString(),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        height: 130,
                        child: InkWell(
                          onTap: () async => changeScreen(
                              context,
                              ProductDetails(
                                  brand: snapshot.data[index].brand,
                                  category: snapshot.data[index].category,
                                  colors: snapshot.data[index].colors,
                                  favoriteId: snapshot.data[index].favoriteId,
                                  featured: snapshot.data[index].feature,
                                  images: snapshot.data[index].images,
                                  name: snapshot.data[index].name,
                                  price: snapshot.data[index].price,
                                  productId: snapshot.data[index].productId,
                                  qty: snapshot.data[index].qty,
                                  sale: snapshot.data[index].sale,
                                  sizes: snapshot.data[index].sizes,
                                  userid: snapshot.data[index].userid,
                                  detail: snapshot.data[index].detail,
                                  callToAction: CallToAction(
                                    brand: snapshot.data[index].brand,
                                    category: snapshot.data[index].category,
                                    colors: snapshot.data[index].colors,
                                    favoriteId: snapshot.data[index].favoriteId,
                                    featured: snapshot.data[index].feature,
                                    images: snapshot.data[index].images,
                                    name: snapshot.data[index].name,
                                    price: snapshot.data[index].price,
                                    productId: snapshot.data[index].productId,
                                    qty: snapshot.data[index].qty,
                                    sale: snapshot.data[index].sale,
                                    sizes: snapshot.data[index].sizes,
                                    userid: snapshot.data[index].userid,
                                    detail: snapshot.data[index].detail,
                                  ),
                                  ifSimilarProduct: SimilarProducts(
                                    productModel: await productctServices
                                        .getSimilarProducts(
                                      snapshot.data[index].category.toString(),
                                    ),
                                  )

                                  // similarList: await productctServices
                                  //     .getSimilarProducts(snapshot
                                  //         .data[index].category
                                  //         .toString()
                                  //         )
                                  )),
                          child: Material(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(1.5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: FadeInImage.memoryNetwork(
                                        fit: BoxFit.cover,
                                        image: snapshot.data[index].images[0],
                                        placeholder: kTransparentImage,
                                      ),
                                      // height: 110,
                                      width: 95,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.all(1.5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 1.5),
                                        child: Text(
                                          snapshot.data[index].name,
                                          style: TextStyle(
                                              fontSize: 18, letterSpacing: 2),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 1.5),
                                        child: Text(
                                          'by: ${snapshot.data[index].brand}',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              letterSpacing: 2),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 1.5),
                                        child: Text(
                                          '\$${snapshot.data[index].price}',
                                          style: TextStyle(
                                              letterSpacing: 2,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black87),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 1.5, 1.5, 1.5),
                                            child: Icon(
                                              Icons.star_outline,
                                              color: Colors.yellow[600],
                                              size: 16,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 1, vertical: 1.5),
                                            child: Icon(
                                              Icons.star_outline,
                                              color: Colors.yellow[600],
                                              size: 16,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 1, vertical: 1.5),
                                            child: Icon(
                                              Icons.star_outline,
                                              color: Colors.yellow[600],
                                              size: 16,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 1, vertical: 1.5),
                                            child: Icon(
                                              Icons.star_outline,
                                              color: Colors.yellow[600],
                                              size: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ))));
  }

  Future<bool> _showMyDeleteDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Delete this product',
              style: TextStyle(color: Colors.white)),
          content: Text('Would you like to  permanently trash this prodcut ? ',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child:
                  const Text('Delete', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }
}
