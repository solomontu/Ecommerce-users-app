import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                color: Colors.blueAccent,
                height: 40,
                width: MediaQuery.of(context).size.width),
            Expanded(child: Container())
            // Expanded(
            //     child: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: ListView.builder(itemBuilder: (context, index) {
            //       return Container(
            //         height: 40,
            //         color: Colors.blueGrey,
            //       );
            //     }),
            //   ),
            // ))
          ],
        );
      }),
    );
  }
}
