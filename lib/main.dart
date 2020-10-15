import 'package:flutter/material.dart';
import 'Screens/singIn.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.pink.shade900
      ),
      home: Login(),
      // ListTest(),
      // MyHomePage(),
    );
  }
}
