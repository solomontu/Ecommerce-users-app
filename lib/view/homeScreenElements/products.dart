import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/product_Services.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/homeScreenElements/productCard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _onsaleProducts = StreamProvider.autoDispose<List<ProductModel>>((ref) {
  final repository = ref.read(servicesProvider);
  return repository.getOnlseStream();
});

class RecentProducts extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<List<ProductModel>> _productProvider = watch(_onsaleProducts);
    return _productProvider.when(
      data: (data) => ListView.builder(
         physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (contex, index) {
            return Column(
              children: [
                Card(
                  elevation: 0,
                  child: ProductCard(
                    productModel: data[index],
                  ),
                ),
                SizedBox()
              ],
            );
          }),
      loading: () => Container(),
      error: (err, stack) => Center(child: Text(err.toString())),
    );
  }
}
