import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.white38,
        child: (Center(
          child: Text(
            'Shopi',
            style: TextStyle(fontSize: 30),
          ),
        )),
      ),
    );
  }
}
