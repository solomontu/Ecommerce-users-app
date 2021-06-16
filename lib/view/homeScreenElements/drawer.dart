import 'package:flutter/material.dart';
import 'package:flutter_ecom/view/Screens/myStore.dart';
import 'package:flutter_ecom/controle/authServices.dart';
import 'package:flutter_ecom/view/Screens/favoriteBody.dart';
import 'package:flutter_ecom/view/Screens/singIn.dart';
import 'package:flutter_ecom/view/common/constants.dart';
import 'package:flutter_ecom/view/Screens/editProfileSreen.dart';
import 'package:flutter_ecom/view/widgets.dart/cartBody.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerItems extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // final _user = Provider.of<AuthWithEmailPassword>(context);
    AuthWithEmailPassword _user = watch(authStatus.notifier);

    return Material(
      child: SizedBox(
        width: 200,
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              UserAccountsDrawerHeader(
                  currentAccountPicture: ClipOval(
                    child: CircleAvatar(
                      maxRadius: 60,
                      child: InkWell(onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile(
                                      uid: _user.user.uid,
                                    )));
                      }),
                      backgroundImage: NetworkImage(
                        _user.userModel.photoUrl,
                      ),
                    ),
                  ),
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartBody()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Row(
                          children: [
                            // MyStore
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Favorite()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Row(
                          children: [
                            // MyStore
                            Icon(
                              Icons.notes,
                              color: kDrawericonsColors,
                              size: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'My shop',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyStore()));
                        },
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
                          if (await _user.logOut()) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          }
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
