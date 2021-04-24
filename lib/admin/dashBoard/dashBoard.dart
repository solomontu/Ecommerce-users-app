import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: OrientationBuilder(builder: (context, orientation) {
            return GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              primary: false,
              padding: const EdgeInsets.all(5),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: <Widget>[
                //users title
                adminTile(
                    icon: Icon(Icons.people_outline), body: 7, title: 'Users'),
                //category tile
                adminTile(
                    icon: Icon(Icons.category), body: 23, title: 'Category'),
                //category tile
                adminTile(
                    icon: Icon(Icons.branding_watermark),
                    body: 173,
                    title: 'Brand'),
                //products tile
                adminTile(
                    icon: Icon(Icons.track_changes),
                    body: 1609,
                    title: 'Products'),
                adminTile(
                    icon: Icon(Icons.insert_emoticon),
                    body: 100,
                    title: 'Sold'),
                adminTile(
                    icon: Icon(Icons.shopping_cart),
                    body: 100,
                    title: 'Orders'),
                adminTile(icon: Icon(Icons.cancel), body: 100, title: 'Return'),
              ],
            );
          }),
        )
      ],
    );
  }


//listtile for the dashboard screen
Widget adminTile({Icon icon, String title, int body, String page}) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // color: Colors.blue
            ),
            // height: 45,
            // width: 35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    icon,
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        // color: Colors.white
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                Text(
                  '$body',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          )));
}}
