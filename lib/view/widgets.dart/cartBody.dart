import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/cartFavoServices.dart';
import 'package:flutter_ecom/models/cartModel.dart';
import 'package:flutter_ecom/view/common/flutterToast.dart';
import 'package:flutter_ecom/view/widgets.dart/appBar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StreamProvider<List<CartModel>> _cartBody =
    StreamProvider<List<CartModel>>((ref) {
  final repository = ref.read(cartFavoriteProvider);
  return repository.getFromcart();
});

// QTY ADDUP
final qtyAdd = StateProvider<int>((ref) {
  int qty;
  return qty++;
});
//QTY REDUCE
final qtyReduce = StateProvider<int>((ref) {
  int qty;
  return qty--;
});

class CartBody extends ConsumerWidget {
  CartFavoriteServices _cartFavoriteServices = CartFavoriteServices();
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<List<CartModel>> _cartProvider = watch(_cartBody);

    return Scaffold(
      appBar: appbar(context,
          add: 'notadd',
          home: 'nothome',
          search: 'notsearch',
          cart: 'hcart',
          store: 'notstore',
          favorite: 'favorite'),
      body: Card(
        child: Center(
          child: Container(
            // color: Colors.grey[350],
            child: _cartProvider.when(
                loading: () => Container(
                    child: Center(
                      child: Container(
                        child: CircularProgressIndicator(
                          semanticsLabel: 'Loading carts',
                        ),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                      ),
                    ),
                    color: Colors.white54,
                    height: MediaQuery.of(context).size.width),
                error: (err, stack) => Center(child: Text(err.toString())),
                data: (data) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Total:',
                                      style: TextStyle(fontSize: 20)),
                                  Text(' \$${200}',
                                      style: TextStyle(fontSize: 20))
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          Expanded(
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) => Dismissible(
                                key: ValueKey<CartModel>(data[index]),
                                direction: DismissDirection.horizontal,
                                onDismissed:
                                    (DismissDirection direction) async {
                                  if (await _cartFavoriteServices
                                      .detletFromCart(
                                          payId: data[index].payId)) {
                                    toast(msg: 'Removed successful');
                                  }
                                },
                                child: Column(
                                  children: [
                                    Card(
                                      child: Column(
                                        children: <Widget>[
                                          //image, name, and cancel row.
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 58,
                                                  width: 50,
                                                  child: Image(
                                                      image: NetworkImage(
                                                          '${data[index].images[0]}')),
                                                ),
                                                Text(
                                                  data[index].name,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),

                                                Text(
                                                    '\$${data[index].cartPrice}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18)),
                                                //putr price here
                                                IconButton(
                                                    icon: Icon(
                                                      Icons
                                                          .favorite_border_outlined,
                                                      color: Colors.pink,
                                                    ),
                                                    onPressed: null),
                                              ],
                                            ),
                                          ),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Row(
                                                children: [
                                                  Text('Size: '),
                                                  Text(
                                                    '${data[index].size}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('Color: '),
                                                  Text('${data[index].color}',
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  InkWell(
                                                    enableFeedback: true,
                                                    child: Icon(
                                                      Icons.arrow_drop_up,
                                                      size: 35,
                                                      color: Colors.black54,
                                                    ),
                                                    onTap: () {
                                                      //INCREASE QUANTITY
                                                      qtyIncrease(
                                                          qty: data[index].qty,
                                                          payId:
                                                              data[index].payId,
                                                          price:
                                                              data[index].price,
                                                          cartPrice: data[index]
                                                              .cartPrice);
                                                    },
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        '${data[index].qty}'),
                                                  ),
                                                  // REDUCE QUANTITY
                                                  InkWell(
                                                      child: Icon(
                                                        Icons.arrow_drop_down,
                                                        size: 35,
                                                        color: Colors.black54,
                                                      ),
                                                      onTap: () {
                                                        qtyDecreace(
                                                            qty:
                                                                data[index].qty,
                                                            payId: data[index]
                                                                .payId,
                                                            price: data[index]
                                                                .price,
                                                            cartPrice:
                                                                data[index]
                                                                    .cartPrice);
                                                      }),
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
                        ],
                      ),
                    )),
          ),
        ),
      ),
      //BUTTOM NAVIGATION BAR
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        color: Colors.white,
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {},
          color: Colors.pink[600],
          child: Text(
            'Checkout',
            style: TextStyle(
                color: Colors.white,
                // fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 2.0),
          ),
        ),
      ),
    );
  }

  void qtyIncrease(
      {String payId, int qty, double price, double cartPrice}) async {
    qty = qty + 1;

    cartPrice = (cartPrice + price);
    String val = cartPrice.toStringAsFixed(3);
    double value = double.parse(val);

    await _cartFavoriteServices.updateCartData(
        payId: payId, qty: qty, cartPrice: value);
  }

  void qtyDecreace(
      {String payId, int qty, double price, double cartPrice}) async {
    if (qty > 1) {
      qty = qty - 1;
      cartPrice = cartPrice - price;
      String val = cartPrice.toStringAsFixed(3);
      double value = double.parse(val);
      await _cartFavoriteServices.updateCartData(
          payId: payId, qty: qty, cartPrice: value);
    }
  }

  int totalPrice() {
    return 2000;
  }
}
