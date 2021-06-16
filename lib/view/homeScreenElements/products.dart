import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/product_Services.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/homeScreenElements/productCard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StreamProvider<List<ProductModel>> _onsaleProducts =
    StreamProvider<List<ProductModel>>((ref) {
  final repository = ref.read(servicesProvider);
  return repository.getOnlseStream();
});

class RecentProducts extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<List<ProductModel>> _productProvider = watch(_onsaleProducts);
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: _productProvider.when(
          data: (data) => SizedBox(
            child: OrientationBuilder(builder: (context, orientation) {
              return ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (contex, index) {
                    return Column(
                      children: [
                        Card(
                          elevation: 0,
                          child: ProductCard(
                            productModel: data[index],
                          ),
                        ),
                        Divider()
                      ],
                    );
                  });
            }),
          ),
          loading: () => Container(),
          error: (err, stack) => Center(child: Text(err.toString())),
        ));
  }
}
