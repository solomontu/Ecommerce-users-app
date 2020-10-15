import 'package:flutter/material.dart';
import 'package:flutter_ecom/homeScreenElements/produtsDetails.dart';

class RecentProducts extends StatelessWidget {
  // static List<Map<String, dynamic>> items
  final List<Map<String, dynamic>> items = [
    {
      'oldPrice': 300,
      'newPrice': 150,
      'productName': "Blazer1",
      'image': 'Assets/images/products/blazer1.jpeg'
    },
    {
      'oldPrice': 790,
      'newPrice': 479.9,
      'productName': "Blazer2",
      'image': 'Assets/images/products/blazer2.jpeg'
    },
    {
      'oldPrice': 1500,
      'newPrice': 670.90,
      'productName': "Red dress",
      'image': 'Assets/images/products/dress1.jpeg'
    },
    {
      'oldPrice': 590,
      'newPrice': 499.9,
      'productName': "Black dress",
      'image': 'Assets/images/products/dress2.jpeg'
    },
    {
      'oldPrice': 270,
      'newPrice': 269.99,
      'productName': "Wine hills",
      'image': 'Assets/images/products/hills1.jpeg'
    },
    {
      'oldPrice': 1500,
      'newPrice': 1100.90,
      'productName': "Red hills",
      'image': 'Assets/images/products/hills2.jpeg'
    },
    {
      'oldPrice': 1450,
      'newPrice': 1300,
      'productName': "Pants1",
      'image': 'Assets/images/products/pants1.jpg'
    },
    {
      'oldPrice': 160,
      'newPrice': 90.75,
      'productName': "Pants2",
      'image': 'Assets/images/products/pants2.jpeg'
    },
    {
      'oldPrice': 850,
      'newPrice': 570,
      'productName': "Skirt1",
      'image': 'Assets/images/products/skt1.jpeg'
    },
    {
      'oldPrice': 1220,
      'newPrice': 900.75,
      'productName': "Skirt2",
      'image': 'Assets/images/products/skt2.jpeg'
    },
    {
      'oldPrice': 1700,
      'newPrice': 1500.90,
      'productName': "Shoe1",
      'image': 'Assets/images/products/shoe1.jpg'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Text(
              'New Products',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Expanded(
              child: OrientationBuilder(builder: (context, orientation) {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 3,
                    ),
                    itemCount: items.length,
                    itemBuilder: (BuildContext contex, int index) {
                      return Product(
                        oldPrice: items[index]['oldPrice'],
                        newPrice: items[index]['newPrice'],
                        productName: items[index]['productName'],
                        image: items[index]['image'],
                      );
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class Product extends StatelessWidget {
  final oldPrice;
  final newPrice;
  final productName;
  final image;

  Product({this.oldPrice, this.newPrice, this.productName, this.image});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Hero(
        tag: productName,
        child: Material(
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetails(
                          productDetailName: productName,
                          pridictDetailPicture: image,
                          productDetailNewPrice: newPrice,
                          productDetailOldPrice: oldPrice,
                        ))),
            child: GridTile(
                footer: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$productName',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '\$$oldPrice',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black87),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '\$$newPrice',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(color: Colors.white54),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }
}
