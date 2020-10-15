import 'package:flutter/material.dart';

import 'Screens/cart.dart';
import 'Screens/myHomePage.dart';

Widget appbar(context, {String button1, String button2, String button3}) {
  return AppBar(elevation: 0.0, title: Text('fashee'), actions: <Widget>[
    iconButtonHelpa(context, button1: button1),
    iconButtonHelpa(context, button2: button2),
    iconButtonHelpa(context, button3: button3),
  ]);
}

//icons buttons helper
iconButtonHelpa(context, {String button1, String button2, String button3}) {
  if (button1 == 'home') {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:3.0),
      child: IconButton(
          icon: Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          }),
    );
  } else if(button3 =='notcart'){
   return Container(
      height: 0,
      width: 0,
    );
  }
  //button 2
  if (button2 == 'search') {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:3.0),
      child: IconButton(
          icon: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Cart()));
          }),
    );
  } else {
    Container(
      height: 0,
      width: 0,
    );
  }
  //button 3
  if (button3 == 'cart') {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:5.0),
      child: IconButton(
          icon: Icon(
            Icons.shopping_cart,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (contex) => Cart()));
          }),
    );
  } else {
    Container(
      height: 0,
      width: 0,
    );
  }
}

//ICONS HELPER FUNCTION
// iconButtonHelper({BuildContext context, String buttons}) {
//   switch (buttons) {
//     case 'home':
//       Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: IconButton(
//             icon: Icon(
//               Icons.home,
//               size: 30,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => MyHomePage()));
//             }),
//       );
//       break;
//     case 'search':
//       Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: IconButton(
//             icon: Icon(
//               Icons.search,
//               size: 30,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               // Navigator.push(
//               //     context, MaterialPageRoute(builder: (contex) => Cart()));
//             }),
//       );
//       break;
//     case 'cart':
//       Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: IconButton(
//             icon: Icon(
//               Icons.home,
//               size: 30,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => Cart()));
//             }),
//       );
//       break;
//     default:
//       Container(
//         height: 0,
//         width: 0,
//       );
//   }
// }
