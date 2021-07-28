import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/product_Services.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/Screens/produtsDetails.dart';
import 'package:flutter_ecom/view/Screens/similarProducts.dart';
import 'package:flutter_ecom/view/common/callToAction.dart';
import 'package:flutter_ecom/view/common/navigation.dart';
import 'package:flutter_ecom/view/common/transparentImage.dart';

class FeatuedCard extends StatelessWidget {
  final ProductModel productModel;

  FeatuedCard({this.productModel});
  ProductctServices productctServices = ProductctServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0.5, right: 0.5, top: 3),
      child: Hero(
        tag: DateTime.now().millisecondsSinceEpoch.toString(),
        child: InkWell(
          splashColor: Colors.pink,
          highlightColor: Colors.pink,
          onTap: () async {
            // ModelTesting(productModel);
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
                        detail: productModel.detail),
                    ifSimilarProduct: SimilarProducts(
                      productModel: await productctServices.getSimilarProducts(
                        productModel.category.toString(),
                      ),
                    )
                    // similarList: await productctServices
                    //     .getSimilarProducts(productModel.category.toString())

                    ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 115,
                width: 115,
                // color: Colors.transparent,IK
                child: Card(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: productModel.images[0]),
                      Positioned(
                          height: 50,
                          bottom: 0,
                          left: 2,
                          right: 2,
                          child: Container(
                            // width: 30,height: 10,
                            color: Colors.white70,
                            child: Column(children: [
                              Text(
                                '${productModel.name}',
                                style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2,
                                    // fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Text(
                                '\$${productModel.price}',
                                style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ]),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
