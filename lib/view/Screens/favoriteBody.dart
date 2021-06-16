import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/cartFavoServices.dart';
import 'package:flutter_ecom/models/favoriteModel.dart';
import 'package:flutter_ecom/view/Screens/produtsDetails.dart';
import 'package:flutter_ecom/view/Screens/searchField.dart';
import 'package:flutter_ecom/view/common/flutterToast.dart';
import 'package:flutter_ecom/view/common/navigation.dart';
import 'package:flutter_ecom/view/common/transparentImage.dart';
import 'package:flutter_ecom/view/common/uuid.dart';
import 'package:flutter_ecom/view/widgets.dart/appBar.dart';
import 'package:flutter_ecom/view/widgets.dart/cartBody.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StreamProvider<List<FavoriteModel>> _favoriteItems =
    StreamProvider<List<FavoriteModel>>((ref) {
  final repository = ref.read(cartFavoriteProvider);
  return repository.getFromFavorite();
});

class Favorite extends ConsumerWidget {
  CartFavoriteServices _cartFavoriteServices = CartFavoriteServices();
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<List<FavoriteModel>> _favoriteProvider = watch(_favoriteItems);
    return Scaffold(
        appBar: appbar(context,
            add: 'notadd',
            home: 'nothome',
            search: 'notsearch',
            cart: 'cart',
            store: 'notstore',
            favorite: 'hfavorite'),
        body: Card(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: _favoriteProvider.when(
              data: (data) => Hero(
                tag: DateTime.now().millisecondsSinceEpoch.toString(),
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => Dismissible(
                          key: ValueKey<FavoriteModel>(data[index]),
                          direction: DismissDirection.horizontal,
                          onDismissed: (DismissDirection direction) async {
                            if (await _cartFavoriteServices.detletFromFavorite(
                                favoriteId: data[index].favoriteId)) {
                              toast(msg: 'Removed successful');
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0, right: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              height: 120,
                              child: Card(
                                child: InkWell(
                                  onTap: () => changeScreen(
                                      context,
                                      ProductDetails(
                                        brand: data[index].brand,
                                        category: data[index].brand,
                                        colors: data[index].colors,
                                        favoriteId: data[index].favoriteId,
                                        featured: data[index].feature,
                                        images: data[index].images,
                                        name: data[index].name,
                                        price: data[index].price,
                                        productId: data[index].productId,
                                        qty: data[index].qty,
                                        sale: data[index].sale,
                                        sizes: data[index].sizes,
                                        userid: data[index].userid,
                                      )),
                                  child: Material(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(1.5),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: FadeInImage.memoryNetwork(
                                                fit: BoxFit.cover,
                                                image: data[index].images[0],
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 1.5),
                                                child: Text(
                                                  data[index].name,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      letterSpacing: 2),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 1.5),
                                                child: Text(
                                                  'by: ${data[index].brand}',
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      letterSpacing: 2),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 1.5),
                                                child: Text(
                                                  '\$${data[index].price}',
                                                  style: TextStyle(
                                                      letterSpacing: 2,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.black87),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        8, 1.5, 1.5, 1.5),
                                                    child: Icon(
                                                      Icons.star_outline,
                                                      color: Colors.yellow[600],
                                                      size: 16,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 1,
                                                        vertical: 1.5),
                                                    child: Icon(
                                                      Icons.star_outline,
                                                      color: Colors.yellow[600],
                                                      size: 16,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 1,
                                                        vertical: 1.5),
                                                    child: Icon(
                                                      Icons.star_outline,
                                                      color: Colors.yellow[600],
                                                      size: 16,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 1,
                                                        vertical: 1.5),
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
                        )),
              ),
              loading: () => Center(
                child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: CircularProgressIndicator()),
              ),
              error: (error, stak) => Center(
                child: Text(error.toString()),
              ),
            ),
          ),
        ));
  }
}
