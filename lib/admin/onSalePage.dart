import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/product_Services.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/Screens/produtsDetails.dart';
import 'package:flutter_ecom/view/common/flutterToast.dart';
import 'package:flutter_ecom/view/common/navigation.dart';
import 'package:flutter_ecom/view/common/transparentImage.dart';
import 'package:flutter_ecom/view/common/userId.dart';
import 'package:flutter_ecom/view/common/visibility.dart';
import 'package:flutter_ecom/view/homeScreenElements/addProduct.dart';

class OnSale extends StatefulWidget {
  const OnSale({Key key}) : super(key: key);

  @override
  _OnSaleState createState() => _OnSaleState();
}

class _OnSaleState extends State<OnSale> {
  ProductctServices _productctServices = ProductctServices();
  bool _deleting;
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          SliverAppBar(
            centerTitle: true,
            expandedHeight: 80,
            title: TextField(
              enabled: true,
              cursorColor: Colors.white,
              style: TextStyle(
                color: Colors.white,
              ),
              enableSuggestions: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 20, left: 8, right: 8),
                hintText: 'Search',
                suffixIcon: IconButton(
                  color: Colors.white,
                  onPressed: () {},
                  icon: Icon(Icons.search_outlined),
                ),
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70)),
              ),
            ),
          ),
        ];
      },
      body: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (contex) => AddProduct(
                          productModel: ProductModel('', 0, 0.0, '', '', '', [],
                              [], [], false, false, '', ''),
                        ))),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    StreamBuilder<List<ProductModel>>(
                      stream: _productctServices.getUserProduct(
                          userId: getUserid()),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ProductModel>> snapshot) {
                        Widget child;
                        if (snapshot.hasError) {
                          child = Center(child: Text('An erro has Occured'));
                        } else {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              child = Center(child: Text('No Connection'));
                              break;
                            case ConnectionState.waiting:
                              child =
                                  Center(child: CircularProgressIndicator());
                              break;
                            case ConnectionState.active:
                              child = userProductBuilder(snapshot);
                              break;
                            case ConnectionState.done:
                              child = userProductBuilder(snapshot);
                              break;
                          }
                        }

                        return child;
                      },
                    )
                  ])),
                ],
              ),
              visibility(context: context, value: _deleting)
            ],
          )),
    );
  }

//################################################

  Widget userProductBuilder(
    AsyncSnapshot<List<ProductModel>> snapshot,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Hero(
                  tag: DateTime.now().millisecondsSinceEpoch.toString(),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: 150,
                      child: InkWell(
                        onTap: () async => changeScreen(
                            context,
                            ProductDetails(
                              brand: snapshot.data[index].brand,
                              category: snapshot.data[index].category,
                              colors: snapshot.data[index].colors,
                              // favoriteId: data[index].favoriteId,
                              featured: snapshot.data[index].feature,
                              images: snapshot.data[index].images,
                              name: snapshot.data[index].name,
                              price: snapshot.data[index].price,
                              productId: snapshot.data[index].productId,
                              qty: snapshot.data[index].qty,
                              sale: snapshot.data[index].sale,
                              sizes: snapshot.data[index].sizes,
                              userid: snapshot.data[index].userid,
                              detail: snapshot.data[index].detail,
                              callToAction: callToActioinStatic(
                                colors: snapshot.data[index].colors,
                                sizes: snapshot.data[index].sizes,
                                brand: snapshot.data[index].brand,
                                category: snapshot.data[index].category,
                                qty: snapshot.data[index].qty,
                                feature: snapshot.data[index].feature,
                                sale: snapshot.data[index].sale,
                              ),
                              // ifSimilarProduct: forDetailPage(index, snapshot),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: FadeInImage.memoryNetwork(
                                  fit: BoxFit.cover,
                                  image: snapshot.data[index].images[0],
                                  placeholder: kTransparentImage,
                                ),
                                height: 145,
                                width: 100,
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
                                      snapshot.data[index].name,
                                      style: TextStyle(
                                          fontSize: 18, letterSpacing: 2),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 1.5),
                                    child: Text(
                                      'by: ${snapshot.data[index].brand}',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          letterSpacing: 2),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 1.5),
                                    child: Text(
                                      '\$${snapshot.data[index].price}',
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
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 1.5, 1.5, 1.5),
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 1.5),
                                    child: Text(
                                      '10/10/2021',
                                      style: TextStyle(
                                          letterSpacing: 2,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black87),
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              changeScreen(
                                                  context,
                                                  AddProduct(
                                                    productModel:
                                                        snapshot.data[index],
                                                  ));
                                            },
                                            child: Text(
                                              'Edit',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  letterSpacing: 1),
                                            )),
                                        InkWell(
                                          onTap: () async {
                                            if (await _showMyDeleteDialog()) {
                                              setState(() {
                                                _deleting = true;
                                              });
                                              if (await _productctServices
                                                  .deletUserProduct()) {
                                                await toast(msg: 'Deleted');
                                              } else {
                                                await toast(
                                                    msg: 'Try again later');
                                              }
                                              setState(() {
                                                _deleting = false;
                                              });
                                            }
                                          },
                                          child: Text('Delete',
                                              style: TextStyle(
                                                  color: Colors.red[700],
                                                  letterSpacing: 1)),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
    );
  }

  Future<bool> _showMyDeleteDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Delete this product',
              style: TextStyle(color: Colors.white)),
          content: Text(
              'Would you like to  permanently delete this prodcut form your store? ',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child:
                  const Text('Delete', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  Widget callToActioinStatic(
      {List colors,
      List sizes,
      String brand,
      String category,
      int qty,
      bool sale,
      bool feature}) {
    return Padding(
        padding: EdgeInsets.all(3),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'On Sale',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black87),
                            ),
                            Switch.adaptive(
                                activeColor:
                                    sale == true ? Colors.grey : Colors.white,
                                value: sale,
                                onChanged: (value) {
                                  sale == true ? value = true : value = false;
                                }),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Featured',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black87),
                            ),
                            Switch.adaptive(
                                activeColor: feature == true
                                    ? Colors.grey
                                    : Colors.white,
                                value: feature,
                                onChanged: (value) {
                                  feature == true
                                      ? value = true
                                      : value = false;
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      'Sizes',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          spacing: 5.0,
                          runSpacing: 20.0,
                          children: sizes
                              .map(
                                (e) => Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              )
                              .toList()),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      'Colors',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          spacing: 5.0,
                          runSpacing: 20.0,
                          children: colors
                              .map(
                                (e) => Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              )
                              .toList()),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Category',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              category,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Brand',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              brand,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Quantity',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '$qty',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
