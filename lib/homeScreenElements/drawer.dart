import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/Screens/cart.dart';
import 'package:flutter_ecom/Screens/myHomePage.dart';
import 'package:flutter_ecom/Screens/singIn.dart';
// import 'package:flutter_ecom/Screens/singIn.dart';
import 'package:flutter_ecom/constants.dart';

class DrawerItems extends StatefulWidget {
  @override
  _DrawerItemsState createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  bool loading = true;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('Assets/ProfileImage/soloc.jpg'),
                // child: Image.asset('Assets/ProfileImage/soloc.jpg',fit: BoxFit.contain,),
              ),
              accountName: Text('Banye Solomon'),
              accountEmail: Text('Likesolomon2@gamil.com')),
          Expanded(
            child: ListView(
              children: <Widget>[
                drawerItem(
                    icon: Icon(
                      Icons.home,
                      color: kDrawericonsColors,
                      size: 25,
                    ),
                    name: 'Home page',
                    position: 'Home',
                    context: context),
                drawerItem(
                    icon: Icon(
                      Icons.person,
                      color: kDrawericonsColors,
                      size: 25,
                    ),
                    name: 'My account',
                    context: context,
                    position: 'account'),
                drawerItem(
                    icon: Icon(
                      Icons.shopping_basket,
                      color: kDrawericonsColors,
                      size: 25,
                    ),
                    name: 'My oders',
                    context: context,
                    position: 'oders'),
                drawerItem(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: kDrawericonsColors,
                      size: 25,
                    ),
                    name: 'Shopping cart',
                    position: 'cart',
                    context: context),
                drawerItem(
                    icon: Icon(
                      Icons.favorite,
                      color: kDrawericonsColors,
                      size: 25,
                    ),
                    name: 'Favorite',
                    context: context,
                    position: 'favorite'),
                SizedBox(
                  height: 30,
                  child: Divider(
                    height: 3,
                  ),
                ),
                drawerItem(
                    icon: Icon(
                      Icons.close,
                      size: 25,
                    ),
                    name: 'Logout',
                    context: context,
                    position: 'logout'),
                drawerItem(
                    icon: Icon(
                      Icons.settings,
                      size: 25,
                    ),
                    name: 'Settings',
                    context: context,
                    position: 'settings'),
                drawerItem(
                    icon: Icon(
                      Icons.help,
                      color: Colors.blue,
                      size: 25,
                    ),
                    name: 'Abut',
                    context: context,
                    position: 'about'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget drawerItem({Icon icon, String name, context, String position}) {
    return ListTile(
      // contentPadding: EdgeInsets.all(2.0),
      leading: icon,
      title: InkWell(
        child: Text(
          name,
          style: TextStyle(fontSize: 16),
        ),
        onTap: () {
          drawerNavigator(context, position);

          MyHomePage(
            loading: loading,
          );
        },
      ),
    );
  }

  drawerNavigator(BuildContext context, String position) {
    Future<void> _logOut() async {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      await firebaseAuth.signOut().whenComplete(() {
        setState(() {
          loading = false;
        });
      });
      firebaseAuth.authStateChanges().listen((User user) {
        if (user == null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
          print('User is currently signed out!');
        }
      });
    }

    switch (position) {
      case 'Home':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
        break;
      case 'cart':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cart()));
        break;
      case 'logout':
        _logOut();

        break;
      default:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
        break;
    }
  }
}
