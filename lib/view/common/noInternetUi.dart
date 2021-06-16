import 'package:flutter/material.dart';

class NoInternetUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.maybeOf(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Icon(
                Icons.wifi_off,
                size: 50,
                color: Colors.grey,
              ),
            ),
            Text(
              'Check your internet connection.....',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
