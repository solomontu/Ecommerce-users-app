import 'package:flutter/material.dart';

class Loadng extends StatelessWidget {
  final String message;

  const Loadng({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('Processing...'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
