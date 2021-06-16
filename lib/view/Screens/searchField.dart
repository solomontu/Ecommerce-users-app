import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/brandGoryService.dart';
import 'package:flutter_ecom/models/goryModel.dart';
import 'package:flutter_ecom/view/widgets.dart/appBar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _categoryValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 100,
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 20),
                          hintText: 'Search',
                          suffixIcon: IconButton(
                            color: Colors.white,
                            onPressed: () {},
                            icon: Icon(Icons.search_outlined),
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70)),
                        ),
                      ),
                    ),
                  ],
                ),
                //DROP DOWN BUTON
                Consumer(builder: (BuildContext context, watch, Widget child) {
                  AsyncValue<List<GoryModel>> stream = watch(goryFutue);
                  return stream.when(
                    data: (data) => SizedBox(
                      height: 30,
                      child: DropdownButton(
                          dropdownColor: Theme.of(context).primaryColor,
                          icon: Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                          underline: SizedBox(),
                          value: _categoryValue,
                          // isExpanded: true,
                          // itemHeight: 5.0,
                          iconDisabledColor: Colors.white,
                          hint: Text(
                            'category',
                            style: TextStyle(color: Colors.white),
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              _categoryValue = newValue;
                            });
                          },
                          items: data.map<DropdownMenuItem>((value) {
                            return DropdownMenuItem<String>(
                                value: value.gory,
                                child: Text(value.gory,
                                    style: TextStyle(color: Colors.white)));
                          }).toList()),
                    ),
                    loading: () => LinearProgressIndicator(),
                    error: (err, stack) => Center(child: Text(err.toString())),
                  );
                }),
              ],
            ),
          ),
          // Expanded(
          //     child: ListView.builder(
          //         itemBuilder: (context, index) => Container(
          //               color: Colors.lightBlue,
          //             )))
        ],
      ),
    ));
  }
}













// TextField(
//                 style: TextStyle(color: Colors.white),
//                 enableSuggestions: true,
//                 decoration: InputDecoration(
//                     hintText: 'Products',
//                     suffixIcon: IconButton(
//                       color: Colors.white,
//                       onPressed: () {},
//                       icon: Icon(Icons.search_outlined),
//                     ),
//                     hintStyle: TextStyle(
//                       color: Colors.white,
//                     ),
//                     focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white70)
//                         // disabledBorder: OutlineInputBorder(borderSide: ),
//                         // enabledBorder: OutlineInputBorder(borderSide: ),
//                         ),
//                     disabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white70),
//                     ),
//                     border: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white70))),
//               ),