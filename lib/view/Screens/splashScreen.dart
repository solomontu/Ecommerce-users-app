import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            // child: ,
          ),
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
                height: MediaQuery.of(context).size.height - 60,
                color: Theme.of(context).primaryColor),
          ),
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.white,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    // backgroundImage:
                    // AssetImage('Assets/images/singleImages/lg.png'),
                    // NetworkImage(
                    //     'https://firebasestorage.googleapis.com/v0/b/ecommerce-cbc61.appspot.com/o/cusom_images%2Flogo.png?alt=media&token=e0029ff3-4a8d-4429-90f2-f159ca4f45f7')
                  ),
                ),
                Text(
                  'Shopi!',
                  style: TextStyle(
                      fontSize: 50,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 3.5),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 1,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipperTwo(reverse: true),
              child: Container(
                height: 120,
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Conneting.....',
                    style: TextStyle(color: Colors.black, letterSpacing: 2.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                   backgroundColor: Colors.white,
//                   radius: 50,
//                   backgroundImage:
//                       // AssetImage('Assets/images/singleImages/lg.png'),
//                       CachedNetworkImageProvider(
//                           'https://firebasestorage.googleapis.com/v0/b/ecommerce-cbc61.appspot.com/o/cusom_images%2Flogo.png?alt=media&token=e0029ff3-4a8d-4429-90f2-f159ca4f45f7')),
//               Text(
//                 'Shopi!',
//                 style: TextStyle(
//                     fontSize: 50,
//                     fontStyle: FontStyle.italic,
//                     fontWeight: FontWeight.w900,
//                     color: Colors.white,
//                     letterSpacing: 3.5),
//               ),
//             ],
//           ),