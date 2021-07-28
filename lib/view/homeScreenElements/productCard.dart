import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/cartFavoServices.dart';
import 'package:flutter_ecom/controle/product_Services.dart';
import 'package:flutter_ecom/models/cartModel.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/Screens/produtsDetails.dart';
import 'package:flutter_ecom/view/Screens/similarProducts.dart';
import 'package:flutter_ecom/view/common/callToAction.dart';
import 'package:flutter_ecom/view/common/constants.dart';
import 'package:flutter_ecom/view/common/flutterToast.dart';
import 'package:flutter_ecom/view/common/navigation.dart';
import 'package:flutter_ecom/view/common/transparentImage.dart';
import 'package:flutter_ecom/view/common/userId.dart';
import 'package:flutter_ecom/view/common/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final star1 = StateProvider<bool>((ref) => false);
final star2 = StateProvider<bool>((ref) => false);
final star3 = StateProvider<bool>((ref) => false);
final star4 = StateProvider<bool>((ref) => false);

class ProductCard extends ConsumerWidget {
  final ProductModel productModel;
  CartFavoriteServices _cartFaServices = CartFavoriteServices();
  ProductCard({
    this.productModel,
  });
  CartModel cartModel = CartModel();
  ProductctServices productctServices = ProductctServices();

  @override
  Widget build(BuildContext context, watch) {
    return Container(
      padding:
          const EdgeInsets.only(right: 8.0, top: 2.5, bottom: 2.5, left: 8),
      child: Stack(
        children: [
          InkWell(
            onTap: () async {
              changeScreen(
                  context,
                  ProductDetails(
                      brand: productModel.brand,
                      category: productModel.category,
                      colors: productModel.colors,
                      featured: productModel.feature,
                      images: productModel.images,
                      name: productModel.name,
                      price: productModel.price,
                      qty: productModel.qty,
                      productId: productModel.productId,
                      sizes: productModel.sizes,
                      sale: productModel.sale,
                      userid: productModel.userid,
                      detail: productModel.detail,
                      // similarList: await productctServices.getSimilarProducts(
                      //   productModel.category.toString(),
                      // ),
                      callToAction: CallToAction(
                        brand: productModel.brand,
                        category: productModel.category,
                        colors: productModel.colors,
                        featured: productModel.feature,
                        images: productModel.images,
                        name: productModel.name,
                        price: productModel.price,
                        qty: productModel.qty,
                        productId: productModel.productId,
                        sizes: productModel.sizes,
                        sale: productModel.sale,
                        userid: productModel.userid,
                        detail: productModel.detail,
                      ),
                      ifSimilarProduct: SimilarProducts(
                        productModel:
                            await productctServices.getSimilarProducts(
                          productModel.category.toString(),
                        ),
                      )));
            },
            child: Hero(
              tag: DateTime.now().millisecondsSinceEpoch.toString(),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                // color: Colors.green,
                height: 115,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1.5),
                      child: Container(
                        child: FadeInImage.memoryNetwork(
                          fit: BoxFit.cover,
                          image: productModel.images[0],
                          placeholder: kTransparentImage,
                        ),
                        height: 115,
                        width: 95,
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(1.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 1.5),
                            child: Text(
                              productModel.name,
                              style: TextStyle(fontSize: 18, letterSpacing: 2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 1.5),
                            child: Text(
                              'by: ${productModel.brand}',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: 2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 1.5),
                            child: Text(
                              '\$${productModel.price}',
                              style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8, 1.5, 1.5, 1.5),
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
          //ADD TO SHOPING FAVORITE
          Positioned(
            bottom: 4.0,
            left: 110,
            child: Container(
              child: InkWell(
                splashColor: Colors.pink,
                highlightColor: kPrimaryColor,
                canRequestFocus: true,
                borderRadius: BorderRadius.circular(20),
                onTap: () async {
                  // await _cartFaServices.favoriteItemExist(
                  //     proId: productModel.productId, userId: getUserid());
                  // print(_cartFaServices.result);

                  if (await _cartFaServices.addToFavorite(
                    {
                      'productId': productModel.productId,
                      'userId': getUserid(),
                      'favoriteId': uuid5,
                      'sellerid': productModel.userid,
                      'category': productModel.category,
                      'sale': productModel.sale,
                      'name': productModel.name,
                      'qty': productModel.qty,
                      'price': productModel.price,
                      'brands': productModel.brand,
                      'colors': productModel.colors,
                      'sizes': productModel.sizes,
                      'images': productModel.images,
                      'featured': productModel.feature,
                      'detail': productModel.detail
                    },
                  )) {
                    toast(msg: 'Product added to your favorite');
                  }
                },
                child: Icon(
                  Icons.favorite_border,
                  color: kPrimaryColor,
                  size: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
