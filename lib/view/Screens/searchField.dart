import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(6, 25, 10, 0),
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        hintText: 'Search products',
                        prefixIcon: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_outlined),
                        ),
                        suffixIcon: IconButton(
                          color: Colors.white,
                          onPressed: () {},
                          icon: Icon(Icons.search_outlined),
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          Expanded(
              child: Container(
                  padding: EdgeInsets.fromLTRB(8, 2, 8, 2), child: ListView()))
        ],
      ),
    );
  }
}
