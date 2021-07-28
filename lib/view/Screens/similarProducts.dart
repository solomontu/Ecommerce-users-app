import 'package:flutter/material.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/Screens/similarProductsCard.dart';

class SimilarProducts extends StatefulWidget {
  final List<ProductModel> productModel;

  const SimilarProducts({Key key, this.productModel}) : super(key: key);

  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Card(
      child: Column(
        children: [
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Similar products',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          )),
          Container(
            // margin: EdgeInsets.symmetric(horizontal: 2),
            height: 180,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(offset: Offset(0, 0), blurRadius: 0),
            ]),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.productModel.length,
              itemBuilder: (BuildContext context, int index) {
                return SimilarProdctsCard(
                  productModel: widget.productModel[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
