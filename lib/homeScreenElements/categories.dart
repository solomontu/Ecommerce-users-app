import 'package:flutter/material.dart';
import 'package:flutter_ecom/constants.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        height: 90,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(offset: Offset(0, 0), blurRadius: 0),
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(flex: 1,
              child: Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Flexible(flex: 3,
              child: Center(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    category(
                        pic: 'Assets/images/cats/accessories.png',
                        tag: 'Accessories'),
                    category(pic: 'Assets/images/cats/dress.png', tag: 'Dress'),
                    category(pic: 'Assets/images/cats/formal.png', tag: 'Formal'),
                    category(
                        pic: 'Assets/images/cats/informal.png', tag: 'Informal'),
                    category(pic: 'Assets/images/cats/tshirt.png', tag: 'Tshirt'),
                    category(pic: 'Assets/images/cats/jeans.png', tag: 'Jeans'),
                    category(pic: 'Assets/images/cats/shoe.png', tag: 'Shoe'),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget category({String pic, String tag}) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: InkWell(
        splashColor: Colors.pink,
        highlightColor: Colors.pink,
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 25,
              width: 50,
              decoration:
                  BoxDecoration(image: DecorationImage(image: AssetImage(pic))),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '$tag',
                style: kCategoriesTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
