import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/authServices.dart';
import 'package:flutter_ecom/controle/providers_services/brandGoryProvider.dart';
import 'package:flutter_ecom/controle/providers_services/product_provider.dart';
import 'package:flutter_ecom/view/Screens/myHomePage.dart';
import 'package:flutter_ecom/view/Screens/singIn.dart';
import 'package:flutter_ecom/view/Screens/splashScreen.dart';
import 'package:flutter_ecom/view/common/constants.dart';
import 'package:flutter_ecom/view/common/loading.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print('initialized');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //  create: (_) => AuthWithEmailPassword.initialize(),
        ChangeNotifierProvider<AuthWithEmailPassword>(
            create: (_) => AuthWithEmailPassword.initialize()),
        ChangeNotifierProvider<ProviderServices>(
            create: (_) => ProviderServices.initalize()),
        ChangeNotifierProvider<BrandGoryProvider>(
            create: (_) => BrandGoryProvider.initialize())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
            primarySwatch: kPrimaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: Colors.pink.shade900),
        home: ScreensController(),
        // ListTest(),
        // MyHomePage(),
      ),
    );
  }
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authEmalPsword = Provider.of<AuthWithEmailPassword>(context);

    switch (_authEmalPsword.status) {
      case Status.unInitialized:
        return Splash();
        break;
      case Status.unauthenticated:
        return Login();
        break;
      case Status.authenticating:
        return Loadng();
        break;
      case Status.authenticated:
        return MyHomePage();
      case Status.processing:
        return MyHomePage();
        break;
      default:
        return Login();
    }
  }
}
