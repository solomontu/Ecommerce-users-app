import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/authServices.dart';
import 'package:flutter_ecom/view/Screens/myHomePage.dart';
import 'package:flutter_ecom/controle/network.dart';
import 'package:flutter_ecom/view/Screens/signup.dart';
import 'package:flutter_ecom/view/Screens/singIn.dart';
import 'package:flutter_ecom/view/Screens/splashScreen.dart';
import 'package:flutter_ecom/view/common/constants.dart';

import 'package:flutter_ecom/view/common/noInternetUi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[100],
            primarySwatch: kPrimaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: Colors.pink[900]),
        home: ScreensController()
        // ListTest(),
        // MyHomePage(),
        );
  }
}

class ScreensController extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final status = watch(authStatus);
    // AuthWithEmailPassword status = watch(authStatus.notifier);

    switch (status) {
      case Status.unInitialized:
        print('THE STATUS IS: $status');
        return Splash();
        break;
      case Status.unauthenticated:
        print('THE STATUS IS: $status');
        return Login();
        break;
      case Status.authenticated:
        print('THE STATUS IS: $status');
        return MyHomePage();
        break;
      case Status.noNetwork:
        print('THE STATUS IS: $status');
        return NoInternetUi();
        break;

      default:
        print('THE STATUS IS: $status');
        return Login();
    }
  }
}

// class NetWorkSellector extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final status = watch(internetSream);
//     // AuthWithEmailPassword status = watch(authStatus.notifier);

//     switch (status) {
//       case true:
//         print('THE STATUS IS: $status');
//         return ScreensController();
//         break;
//       case false:
//         print('THE STATUS IS: $status');
//         return NoInternetUi();
//         break;
//       default:
//         print('THE STATUS IS: $status');
//         return Login();
//     }
//   }
// }
