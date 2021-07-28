import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/view/Screens/myStore.dart';
import 'package:flutter_ecom/controle/authServices.dart';
import 'package:flutter_ecom/view/Screens/favoriteBody.dart';
import 'package:flutter_ecom/view/Screens/singIn.dart';
import 'package:flutter_ecom/view/Screens/userEditSreen.dart';
import 'package:flutter_ecom/view/common/constants.dart';
import 'package:flutter_ecom/view/widgets.dart/cartBody.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerItems extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // final _user = Provider.of<AuthWithEmailPassword>(context);
    AuthWithEmailPassword _user = watch(authStatus.notifier);

    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 260,
        color: Theme.of(context).primaryColor,
        // width: 200,
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Theme.of(context).primaryColor,
                height: 210,
                padding: EdgeInsets.only(
                  top: 40,
                  bottom: 13,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 10),
                          child: Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile(
                                            uid: _user.user.uid,
                                          ))),
                              child: ClipOval(
                                child: _user.userModel.photoUrl != null
                                    ? CachedNetworkImage(
                                        fit: BoxFit.scaleDown,
                                        imageUrl: _user.userModel.photoUrl,
                                        height: 80,
                                      )
                                    : Icon(Icons.person_add,
                                        size: 60, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      runAlignment: WrapAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            '${_user.userModel.firstName} ${_user.userModel.surName}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                wordSpacing: 2.5,
                                letterSpacing: 1.0),
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      runAlignment: WrapAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 10),
                          child: Text(
                            _user.userModel.email,
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 1.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                height: 0.5,
                color: Colors.white38,
              ),
              // UserAccountsDrawerHeader(
              //     currentAccountPictureSize: Size.square(82.0),
              //     currentAccountPicture: InkWell(
              //       onTap: () => Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => EditProfile(
              //                     uid: _user.user.uid,
              //                   ))),
              //       child: ClipOval(
              //         child: _user.userModel.photoUrl != null
              //             ? CachedNetworkImage(
              //                 imageUrl: _user.userModel.photoUrl)
              //             : Icon(Icons.person_add,
              //                 size: 60, color: Colors.white),
              //       ),
              //     ),
              //     accountName: Text(
              //       '${_user.userModel.firstName} ${_user.userModel.surName}',
              //       style: TextStyle(
              //           fontSize: 22, wordSpacing: 2.5, letterSpacing: 1.0),
              //     ),
              //     accountEmail: Text(
              //       _user.userModel.email,
              //       style: TextStyle(fontSize: 16),
              //     )),
              Expanded(
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0, left: 10, right: 10),
                        child: GestureDetector(
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('My account',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_basket,
                                color: Colors.white,
                                size: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'My orders',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Row(
                            children: [
                              // MyStore
                              Icon(
                                Icons.notes,
                                color: Colors.white,
                                size: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'My shop',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
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
                      Divider(
                        height: 0.5,
                        color: Colors.white38,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Row(
                            children: [
                              Icon(Icons.close, size: 30, color: Colors.white),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
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
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Row(
                            children: [
                              Icon(Icons.settings,
                                  size: 30, color: Colors.white),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Settings',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Row(
                            children: [
                              Icon(Icons.help, size: 30, color: Colors.white),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'About',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
