import 'package:flutter/material.dart';

Widget visibility({BuildContext context, bool value}) {
  return Visibility(
      visible: value == true,
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white30,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: CircularProgressIndicator(
                backgroundColor: Colors.white70,
              ),
            ),
          ))));
}
