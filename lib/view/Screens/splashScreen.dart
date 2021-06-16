import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        // Colors.white38,
        child: (Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  backgroundImage:
                      // AssetImage('Assets/images/singleImages/lg.png'),
                      CachedNetworkImageProvider(
                          'https://firebasestorage.googleapis.com/v0/b/ecommerce-cbc61.appspot.com/o/cusom_images%2Flogo.png?alt=media&token=e0029ff3-4a8d-4429-90f2-f159ca4f45f7')),
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
        )),
      ),
    );
  }
}
