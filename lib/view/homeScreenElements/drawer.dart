import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/authServices.dart';
import 'package:flutter_ecom/controle/editProfileCont.dart';
import 'package:flutter_ecom/models/userModel.dart';
// import 'package:flutter_ecom/Screens/singIn.dart';
import 'package:flutter_ecom/view/Screens/myHomePage.dart';
import 'package:flutter_ecom/view/common/constants.dart';
import 'package:flutter_ecom/view/common/transparentImage.dart';
import 'package:flutter_ecom/view/Screens/editProfileSreen.dart';
import 'package:provider/provider.dart';

class DrawerItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<AuthWithEmailPassword>(context);

    return Material(
      child: SizedBox(
        width: 200,
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              UserAccountsDrawerHeader(
                  currentAccountPicture: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: CircleAvatar(maxRadius: 50,
                        child: InkWell(onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                        uid: _user.user.uid,
                                      )));
                        }),
                        backgroundImage: _user.userModel.photoUrl == null
                            ? AssetImage(
                                'Assets/ProfileImage/profile image.png')
                            : CachedNetworkImage(imageUrl:_user.userModel.photoUrl,),
                      )),
                  accountName: Text(
                    '${_user.userModel.firstName} ${_user.userModel.surName}',
                    style: TextStyle(
                        fontSize: 22, wordSpacing: 2.5, letterSpacing: 1.0),
                  ),
                  accountEmail: Text(
                    _user.userModel.email,
                    style: TextStyle(fontSize: 19),
                  )),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Row(
                          children: [
                            Icon(
                              Icons.home,
                              color: kDrawericonsColors,
                              size: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Home',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: kDrawericonsColors,
                              size: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'My account',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_basket,
                              color: kDrawericonsColors,
                              size: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'My orders',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: kDrawericonsColors,
                              size: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Cart',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: kDrawericonsColors,
                              size: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Favorite',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: Divider(
                        height: 3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Row(
                          children: [
                            Icon(
                              Icons.close,
                              size: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Logout',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        onTap: () async {
                          await _user.logOut();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings,
                              size: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Settings',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Row(
                          children: [
                            Icon(
                              Icons.help,
                              size: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'About',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


