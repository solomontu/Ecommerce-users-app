import 'package:flutter/material.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/Screens/produtsDetails.dart';
import 'package:flutter_ecom/view/common/navigation.dart';
import 'package:flutter_ecom/view/common/transparentImage.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;

  const ProductCard({Key key, this.productModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8, bottom: 8),
      child: Hero(
        tag: productModel.name,
        child: Material(
          child: InkWell(
            onTap: () => changeScreen(
                context, ProductDetails(productModel: productModel)),

            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => ProductDetails(
            //            productModel: productModel,
            //             ))),
            child: ListTile(
              leading: Container(
                child: FadeInImage.memoryNetwork(
                  fit: BoxFit.cover,
                  image: productModel.images[0],
                  placeholder: kTransparentImage,
                ),
                height: 120,
                width: 80,
              ),
              title: Text(
                productModel.name,
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('by: ${productModel.brand}'),
                  Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: [
                      Text(
                        '\$${productModel.price}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87),
                      ),
                      Text(
                        'On sale',
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
