import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/providers_services/product_provider.dart';
import 'package:flutter_ecom/view/Screens/produtsDetails.dart';
import 'package:flutter_ecom/view/common/transparentImage.dart';
import 'package:flutter_ecom/view/homeScreenElements/productCard.dart';
import 'package:provider/provider.dart';

class RecentProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProviderServices _productProvider = Provider.of<ProviderServices>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SizedBox(
        child: OrientationBuilder(builder: (context, orientation) {
          return ListView.builder(
              itemCount: _productProvider.onSaleList.length,
              itemBuilder: (contex, index) {
                return ProductCard(
                  productModel: _productProvider.onSaleList[index],
                );
              });
        }),
      ),
    );
  }
}
