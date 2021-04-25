import 'package:flutter/material.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/Screens/produtsDetails.dart';
import 'package:flutter_ecom/view/common/navigation.dart';
import 'package:flutter_ecom/view/common/transparentImage.dart';

class FeatuedCard extends StatelessWidget {
  final ProductModel productModel;

  const FeatuedCard({Key key, this.productModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 2.5, right: 2.5, top: 5),
      child: Hero(
        tag: productModel.id,
        child: InkWell(
          splashColor: Colors.pink,
          highlightColor: Colors.pink,
          onTap: () {
            // ModelTesting(productModel);
            changeScreen(context, ProductDetails(productModel: productModel));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 135,
                width: 110,
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
                                    // fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Text(
                                '\$${productModel.price}',
                                style: TextStyle(
                                    fontSize: 20,
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
