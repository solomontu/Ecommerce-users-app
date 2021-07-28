import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/product_Services.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/homeScreenElements/featuredCard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StreamProvider<List<ProductModel>> featuredProdutcts =
    StreamProvider<List<ProductModel>>((ref) {
  final repository = ref.read(servicesProvider);
  return repository.getFeaturedStream();
});

class FeaturedProducts extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    AsyncValue<List<ProductModel>> _featureProducts = watch(featuredProdutcts);

    return _featureProducts.when(
      data: (value) => Container(
        // margin: EdgeInsets.symmetric(horizontal: 1),
        height: 120,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(color: Colors.white, boxShadow: [
        //   BoxShadow(offset: Offset(0, 0), blurRadius: 0),
        // ]),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: value.length,
          itemBuilder: (BuildContext context, int index) {
            return FeatuedCard(
              productModel: value[index],
            );
          },
        ),
      ),
      loading: () => Container(),
      error: (err, stack) => Center(child: Text(err.toString())),
    );
  }
}
