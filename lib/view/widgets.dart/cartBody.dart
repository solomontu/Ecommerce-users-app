import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/authServices.dart';
import 'package:flutter_ecom/controle/cartFavoServices.dart';
import 'package:flutter_ecom/controle/cartTotalPriceService.dart';
import 'package:flutter_ecom/models/cartModel.dart';
import 'package:flutter_ecom/view/common/flutterToast.dart';
import 'package:flutter_ecom/view/common/userId.dart';
import 'package:flutter_ecom/view/common/visibility.dart';
import 'package:flutter_ecom/view/widgets.dart/appBar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//CART TOTALPRICE LIST OF CARTPRICE MODLE
final _cartTtoalPrice = StreamProvider.autoDispose<double>((ref) {
  final repository = ref.watch(cartTotalPricePrivder);
  return repository.getCartTotlPrice(userId: getUserid());
});

class CartBody extends StatefulWidget {
  const CartBody({Key key}) : super(key: key);

  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  CartFavoriteServices _cartFavoriteServices = CartFavoriteServices();

  CartTotalpriceService _cartTotalpriceService = CartTotalpriceService();
  bool _deleting;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar(context,
            add: 'notadd',
            home: 'nothome',
            search: 'notsearch',
            cart: 'hcart',
            store: 'notstore',
            favorite: 'notfavorite'),
        body: Stack(
          fit: StackFit.expand,
          children: [
            StreamBuilder<List<CartModel>>(
              stream: _cartFavoriteServices.getFromcart(userId: getUserid()),
              builder: (BuildContext context,
                  AsyncSnapshot<List<CartModel>> snapshot) {
                Widget child;
                if (snapshot.hasError) {
                  child = Center(child: Text('An erro has Occured'));
                } else {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      child = Center(child: Text('No Connection'));
                      break;
                    case ConnectionState.waiting:
                      child = Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.active:
                      child = userCartBuilder(snapshot);
                      break;
                    case ConnectionState.done:
                      child = userCartBuilder(snapshot);
                      break;
                  }
                }

                return child;
              },
            ),
            visibility(context: context, value: _deleting)
          ],
        ));
  }

  Widget userCartBuilder(AsyncSnapshot<List<CartModel>> snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Card(
            child:
                Consumer(builder: (BuildContext context, watch, Widget child) {
              final AsyncValue<double> cartTotalPrice = watch(_cartTtoalPrice);

              return cartTotalPrice.when(
                data: (data) => Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Total:', style: TextStyle(fontSize: 20)),
                      Text(' \$${data.toStringAsFixed(4)}',
                          style: TextStyle(fontSize: 20))
                    ],
                  ),
                ),
                loading: () =>
                    Text(' \$${000}', style: TextStyle(fontSize: 20)),
                error: (err, stack) => Center(child: Text(err.toString())),
              );
            }),
          ),
        ),
        ///////////////////////////////
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            color: Colors.white54,
            height: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => Dismissible(
                background: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.delete, color: Colors.grey),
                          Text('Move to trash',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(Icons.delete, color: Colors.grey),
                        Text('Move to trash',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                confirmDismiss: (DismissDirection dismissDirection) =>
                    _showMyDeleteDialog(context),
                key: ValueKey<CartModel>(snapshot.data[index]),
                direction: DismissDirection.horizontal,
                onDismissed: (DismissDirection direction) async {
                  setState(() {
                    _deleting = true;
                  });
                  if (await _cartFavoriteServices.detletFromCart(
                      payId: snapshot.data[index].payId)) {
                    await _cartTotalpriceService.deCartTotal(
                        userId: getUserid(),
                        cartPrice: snapshot.data[index].cartPrice);
                    toast(msg: 'Deleted');
                  }
                  setState(() {
                    _deleting = false;
                  });
                },
                child: Column(
                  children: [
                    Card(
                      child: Column(
                        children: <Widget>[
                          //image, name, and cancel row.
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  height: 80,
                                  width: 100,
                                  child: Image(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                          '${snapshot.data[index].images[0]}')),
                                ),
                                Text(
                                  snapshot.data[index].name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                                Text('\$${snapshot.data[index].cartPrice}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                //putr price here
                                IconButton(
                                    icon: Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.pink,
                                    ),
                                    onPressed: null),
                              ],
                            ),
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text('Size: '),
                                  Text(
                                    '${snapshot.data[index].size}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Color: '),
                                  Text('${snapshot.data[index].color}',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  // InkWell(
                                  //   enableFeedback: true,
                                  //   child: Icon(
                                  //     Icons.arrow_drop_up,
                                  //     size: 35,
                                  //     color: Colors.black54,
                                  //   ),
                                  //   onTap: () {
                                  //     //INCREASE QUANTITY
                                  //     qtyIncrease(
                                  //         qty: data[index].qty,
                                  //         payId:
                                  //             data[index].payId,
                                  //         price:
                                  //             data[index].price,
                                  //         cartPrice: data[index]
                                  //             .cartPrice);
                                  //   },
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Text('QTY: '),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('${snapshot.data[index].qty}'),
                                  ),
                                  // REDUCE QUANTITY
                                  // InkWell(
                                  //     child: Icon(
                                  //       Icons.arrow_drop_down,
                                  //       size: 35,
                                  //       color: Colors.black54,
                                  //     ),
                                  //     onTap: () {
                                  //       qtyDecreace(
                                  //           qty:
                                  //               data[index].qty,
                                  //           payId: data[index]
                                  //               .payId,
                                  //           price: data[index]
                                  //               .price,
                                  //           cartPrice:
                                  //               data[index]
                                  //                   .cartPrice);
                                  //     }),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {},
                  color: Theme.of(context).primaryColorDark,
                  child: Text(
                    'Checkout',
                    style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 2.0),
                  ),
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        )
      ],
    );
  }

  Future<bool> _showMyDeleteDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Delete this product',
              style: TextStyle(color: Colors.white)),
          content: Text(
              'Would you like to  permanently tras this prodcut to trash ? ',
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

  void qtyIncrease(
      {String payId, int qty, double price, double cartPrice}) async {
    qty = qty + 1;

    cartPrice = (cartPrice + price);
    // String val = cartPrice.toStringAsFixed(3);
    // double value = double.parse(val);

    await _cartFavoriteServices.updateCartData(
        payId: payId, qty: qty, cartPrice: cartPrice);
  }

  void qtyDecreace(
      {String payId, int qty, double price, double cartPrice}) async {
    if (qty > 1) {
      qty = qty - 1;
      cartPrice = cartPrice - price;
      // String val = cartPrice.toStringAsFixed(3);
      // double value = double.parse(val);
      await _cartFavoriteServices.updateCartData(
          payId: payId, qty: qty, cartPrice: cartPrice);
    }
  }
}
