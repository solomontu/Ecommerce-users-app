import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/providers_services/product_provider.dart';
import 'package:flutter_ecom/view/homeScreenElements/featuredCard.dart';
import 'package:provider/provider.dart';

class FeaturedProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProviderServices _productProvider = Provider.of<ProviderServices>(context);

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        height: 150,
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(offset: Offset(0, 0), blurRadius: 0),
        ]),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _productProvider.featuredList.length,
          itemBuilder: (BuildContext context, int index) {
            return FeatuedCard(
              productModel: _productProvider.featuredList[index],
            );
          },
        ));
  }
}
