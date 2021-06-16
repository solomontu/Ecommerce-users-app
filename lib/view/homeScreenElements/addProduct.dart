import 'package:flutter/material.dart';
import 'package:flutter_ecom/admin/db/products.dart';
import 'package:flutter_ecom/controle/brandGoryService.dart';
import 'package:flutter_ecom/models/goryModel.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/common/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:circular_check_box/circular_check_box.dart';

// import 'package:event/event.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String> sellectedProdutSizes = [];
  ProductServices _productServices = ProductServices();

  ProductModel _productModel = ProductModel();
  final _poductFormKey = GlobalKey<FormState>();

  bool isLoading = false;

  //Image holder
  final picker = ImagePicker();
  //BRAND LIST VALUE
  String categoryvalue;
  File _image1;
  File _image2;
  File _image3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.close, color: Colors.white),
          onTap: () => Navigator.pop(context),
        ),
        elevation: 0,
        title: Text('Add products',
            style: TextStyle(
                color: Colors.white, letterSpacing: 2.0, fontSize: 25)),
        backgroundColor: Theme.of(context).primaryColor,
      ),

      //porduct attribute
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _poductFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      imagePlaceHolder('image1', _productModel),
                      imagePlaceHolder('_image2', _productModel),
                      imagePlaceHolder('_image3', _productModel),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Featured'),
                          Switch(
                              activeColor: Theme.of(context).primaryColor,
                              value: _productModel.featuredState(),
                              onChanged: (bool value) {
                                setState(() {
                                  _productModel.featuredAction();
                                });
                              })
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                      Row(
                        children: [
                          Text('sale'),
                          Switch(
                              activeColor: Theme.of(context).primaryColor,
                              value: _productModel.saleState(),
                              onChanged: (bool value) {
                                setState(() {
                                  _productModel.saleAction();
                                });
                              })
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                    ],
                  ),

                  //product name
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: TextFormField(
                      onChanged: (value) {
                        _productModel.name = value;
                      },
                      maxLength: 10,
                      validator: (value) =>
                          value.isEmpty ? 'Name is requred' : null,
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                    ),
                  ),
                  //PRODUCT DESCRIPTION
                  InkWell(
                    onTap: () {
                      productDetailDialog(context, _productModel);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Detals',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Divider(
                              height: 30,
                              thickness: 1.7,
                              color: Colors.grey[500]),
                        ],
                      ),
                    ),
                  ),

                  //pruoduct quantity
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: TextFormField(
                            // onChanged: _productQty(_productModel),
                            keyboardType: TextInputType.number,
                            // controller: _productQuantityController,
                            onChanged: (newValue) {
                              _productModel.qty = int.parse(newValue);
                            },
                            maxLength: 10,
                            validator: (value) =>
                                value.isEmpty ? 'Quantity is required' : null,
                            decoration: InputDecoration(
                              hintText: 'Qty',
                            ),
                          ),
                        ),
                      ),
                      //Product price
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            // controller: _productPriceController,
                            // onChanged: (value) => _productPrice(_productModel),
                            onChanged: (newValue) {
                              _productModel.price = double.parse(newValue);
                            },
                            maxLength: 10,
                            validator: (value) =>
                                value.isEmpty ? 'Price is required' : null,
                            decoration: InputDecoration(
                              hintText: 'Price',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        //category listTile;
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: TextFormField(
                              // controller: _productPriceController,
                              // onChanged: (value) => _productPrice(_productModel),
                              onChanged: (newValue) {
                                _productModel.brand = newValue;
                              },

                              validator: (value) =>
                                  value.isEmpty ? 'Brandis required' : null,
                              decoration: InputDecoration(
                                hintText: 'Brand',
                              ),
                            ),
                          ),
                        ),

                        //CATEGORY listTile;
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Consumer(builder: (BuildContext context,
                                    watch, Widget child) {
                                  AsyncValue<List<GoryModel>> stream =
                                      watch(goryStream);
                                  return stream.when(
                                    data: (data) => SizedBox(
                                      height: 30,
                                      child: DropdownButton(
                                          isExpanded: false,
                                          isDense: false,
                                          dropdownColor:
                                              Theme.of(context).primaryColor,
                                          underline: SizedBox(),
                                          value: _productModel.category,
                                          // isExpanded: true,
                                          hint: Text('category'),
                                          onChanged: (newValue) {
                                            _productModel.category = newValue;
                                          },
                                          items: data
                                              .map<DropdownMenuItem>((value) {
                                            return DropdownMenuItem<String>(
                                                value: value.gory,
                                                child: Text(value.gory,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14)));
                                          }).toList()),
                                    ),
                                    loading: () => LinearProgressIndicator(),
                                    error: (err, stack) =>
                                        Center(child: Text(err.toString())),
                                  );
                                }))),
                      ],
                    ),
                  ),

                  //MATERIAL BUTTON FOR SIZES dialogue
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () async {
                              await buildShowDialog(context, _productModel);
                            },
                            child: Text(
                              'Colors',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[600]),
                            ),
                          ),
                        ),
                      ), //MATERIAL BUTTON FOR SIZES dialogue
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () {
                              sellectSizes(_productModel);
                              sellectedProdutSizes.clear();
                            },
                            child: Text(
                              'Sizes',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[600]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //Save form button with validation
                  // Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //     child: MaterialButton(
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10)),

                  //       color: Colors.pink,
                  //       child: Text(
                  //         'Create',
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             // fontWeight: FontWeight.bold,
                  //             fontSize: 20,
                  //             letterSpacing: 2.0),
                  //       ),
                  //       //AD PRODUCT
                  //       onPressed: () async {
                  //         addProduct(context, _productModel);
                  //       },
                  //     ))
                ],
              ),
            ),
          ),
        ),
      ),
      //add Product BUTTOM NAVIGATION BAR
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        color: Colors.white,
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () async {
            addProduct(context, _productModel);
          },
          color: Colors.pink[600],
          child: Text(
            'Create product',
            style: TextStyle(
                color: Colors.white,
                // fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 2.0),
          ),
        ),
      ),
    );
  }

  Future<void> productDetailDialog(
      BuildContext context, ProductModel _productModel) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Product description',
              style: TextStyle(color: Colors.white),
            ),
            content: StatefulBuilder(builder: (context, StateSetter setState) {
              return TextFormField(
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  _productModel.detail = value;
                },
                maxLines: 80,
                validator: (value) =>
                    value.isEmpty ? 'Deiscripion is requred' : null,
                decoration: InputDecoration(
                  hintText: 'Detail ',
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70)),
                ),
              );
            }),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    // print(sellectedProdutSizes.length);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
            actionsPadding: EdgeInsets.symmetric(horizontal: 30.0),
          );
        });
  }

  Future<void> buildShowDialog(
      BuildContext context, ProductModel _productModel) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Colours',
              style: TextStyle(color: Colors.white),
            ),
            content: StatefulBuilder(builder: (context, StateSetter setState) {
              return Wrap(runSpacing: 5.0, spacing: 5.0, children: [
                Checkbox(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    value: _productModel.checkBoxState('blue'),
                    // inactiveColor: Colors.blue,
                    activeColor: Colors.blue,
                    onChanged: (bool value) {
                      setState(() {
                        _productModel.colors.contains('blue')
                            ? _productModel.removeColor('blue')
                            : _productModel.addColor('blue');
                      });
                    }),
                Checkbox(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    value: _productModel.checkBoxState('orange'),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    // inactiveColor: Colors.orange,
                    activeColor: Colors.orange,
                    onChanged: (bool value) {
                      setState(() {
                        _productModel.colors.contains('orange')
                            ? _productModel.removeColor('orange')
                            : _productModel.addColor('orange');
                      });
                    }),
                Checkbox(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    value: _productModel.checkBoxState('purple'),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    // inactiveColor: Colors.purple,
                    activeColor: Colors.purple,
                    onChanged: (bool value) {
                      setState(() {
                        _productModel.colors.contains('purple')
                            ? _productModel.removeColor('purple')
                            : _productModel.addColor('purple');
                      });
                    }),
                Checkbox(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    value: _productModel.checkBoxState('yellow'),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    // inactiveColor: Colors.yellow,
                    activeColor: Colors.yellow,
                    onChanged: (bool value) {
                      setState(() {
                        _productModel.colors.contains('yellow')
                            ? _productModel.removeColor('yellow')
                            : _productModel.addColor('yellow');
                      });
                    }),
                Checkbox(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    value: _productModel.checkBoxState('pink'),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    // fillColor: MaterialStateProperty.resolveWith(Colors.pink),
                    activeColor: Colors.pink,
                    onChanged: (bool value) {
                      setState(() {
                        _productModel.colors.contains('pink')
                            ? _productModel.removeColor('pink')
                            : _productModel.addColor('pink');
                      });
                    }),
              ]);
            }),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    // print(sellectedProdutSizes.length);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
            actionsPadding: EdgeInsets.symmetric(horizontal: 30.0),
          );
        });
  }

  //SIZES DIALOGUE
  sellectSizes(ProductModel _productModel) async {
    await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('Availeble sizes',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                )),

            //str
            content: StatefulBuilder(builder: (context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(child: Text('XS')),
                      Flexible(
                        child: Checkbox(
                            value: _productModel.sizeCheckState('xs'),
                            onChanged: (value) {
                              setState(() {
                                _productModel.sizes.contains('xs')
                                    ? _productModel.removeSize('xs')
                                    : _productModel.addSize('xs');
                              });
                            }),
                      ),
                      Flexible(child: Text('S')),
                      Flexible(
                        child: Checkbox(
                            value: _productModel.sizeCheckState('s'),
                            onChanged: (value) {
                              setState(() {
                                _productModel.sizes.contains('s')
                                    ? _productModel.removeSize('s')
                                    : _productModel.addSize('s');
                              });
                            }),
                      ),
                      Flexible(child: Text('M')),
                      Flexible(
                        child: Checkbox(
                            value: _productModel.sizeCheckState('m'),
                            onChanged: (value) {
                              setState(() {
                                _productModel.sizes.contains('m')
                                    ? _productModel.removeSize('m')
                                    : _productModel.addSize('m');
                              });
                            }),
                      ),
                    ],
                  ),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(child: Text('L')),
                      Flexible(
                        child: Checkbox(
                            value: _productModel.sizeCheckState('l'),
                            onChanged: (value) {
                              setState(() {
                                _productModel.sizes.contains('l')
                                    ? _productModel.removeSize('l')
                                    : _productModel.addSize('l');
                              });
                            }),
                      ),
                      Flexible(child: Text('XL')),
                      Flexible(
                        child: Checkbox(
                            value: _productModel.sizeCheckState('xl'),
                            onChanged: (value) {
                              setState(() {
                                _productModel.sizes.contains('xl')
                                    ? _productModel.removeSize('xl')
                                    : _productModel.addSize('xl');
                              });
                            }),
                      ),
                      Flexible(child: Text('XXL')),
                      Flexible(
                        child: Checkbox(
                            value: _productModel.sizeCheckState('xxl'),
                            onChanged: (value) {
                              setState(() {
                                _productModel.sizes.contains('xxl')
                                    ? _productModel.removeSize('xxl')
                                    : _productModel.addSize('xxl');
                              });
                            }),
                      ),
                    ],
                  ),
                ],
              );
            }),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    print(sellectedProdutSizes.length);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
            actionsPadding: EdgeInsets.symmetric(horizontal: 30.0),
          );
        });
  }

  /*For image picker to work; ensure u iMPORT DART:IO */
  //IMAGE PICKER HANDLER
  Future getImage(String image, ProductModel _productModel) async {
    try {
      var pickedFile = await picker.getImage(source: ImageSource.gallery);
      switch (image) {
        case 'image1':
          setState(() {
            _image1 = File(pickedFile.path);
          });
          break;
        case '_image2':
          setState(() {
            _image2 = File(pickedFile.path);
          });
          break;
        case '_image3':
          setState(() {
            _image3 = File(pickedFile.path);
          });
          break;
        default:
      }
    } catch (e) {
      print(e);
    }
  }

  //show image or icon
  Widget image(String img, ProductModel _productModel) {
    var displayImage;
    if (img == 'image1') {
      if (_image1 == null) {
        displayImage =
            Icon(Icons.camera_alt, color: Colors.grey.withOpacity(0.9));
      } else {
        setState(() {
          displayImage =
              Image.file(_image1, fit: BoxFit.fill, width: double.infinity);
        });
      }
    }
    //image 2
    if (img == '_image2') {
      if (_image2 == null) {
        displayImage =
            Icon(Icons.camera_alt, color: Colors.grey.withOpacity(0.9));
      } else {
        setState(() {
          displayImage =
              Image.file(_image2, fit: BoxFit.fill, width: double.infinity);
        });
      }
    }
    //image 3
    if (img == '_image3') {
      if (_image3 == null) {
        return Icon(Icons.camera_alt, color: Colors.grey.withOpacity(0.9));
      } else {
        setState(() {
          displayImage =
              Image.file(_image3, fit: BoxFit.fill, width: double.infinity);
        });
      }
    }
    return displayImage;
  }

  // Image plceholder
  Widget imagePlaceHolder(String imgPickerWget, ProductModel _productModel) {
    return Expanded(
      child: GestureDetector(
        onTap: () => getImage(imgPickerWget, _productModel),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            height: 80,
            width: 60,
            child: image(imgPickerWget, _productModel),
          ),
        ),
      ),
    );
  }

//ad prodct function
  void addProduct(BuildContext context, ProductModel _productModel) async {
    Map map = _productModel.toMap();
    FormState formState = _poductFormKey.currentState;
    if (formState.validate()) {
      assert(
          _image1 != null && _image2 != null && _image3 != null,
          Fluttertoast.showToast(
              msg: 'Requress three product imgaes', backgroundColor: kRedColr));
      assert(
          _productModel.category != null,
          Fluttertoast.showToast(
              msg: 'Reques product category', backgroundColor: kRedColr));
      assert(
          _productModel.sizes.isNotEmpty,
          Fluttertoast.showToast(
              msg: 'Reques product sizes', backgroundColor: kRedColr));
      assert(
          _productModel.colors.isNotEmpty,
          Fluttertoast.showToast(
              msg: 'Requires product colors', backgroundColor: kRedColr));

      isLoading = true;
      await uploadImage(_productModel);
      await _productServices.createProduct(map);

      formState.reset();
      Fluttertoast.showToast(msg: 'Product added', backgroundColor: kRedColr);
      Navigator.pop(context);
    }
    isLoading = false;
  }

  Future uploadImage(ProductModel providr) async {
////////////////////////////////////////////Imge 1
    final String picture1Name1 =
        '1${DateTime.now().millisecondsSinceEpoch.toString()}.png';
    try {
      var putfile = await firebase_storage.FirebaseStorage.instance
          .ref('/product_image')
          .child(picture1Name1)
          .putFile(_image1);
      var fileaUrl = await putfile.ref.getDownloadURL();
      _productModel.images.add(fileaUrl);
    } on Exception catch (e) {
      print(e.toString);
    }

    ////////////////////////////////////////////Imge 2

    final String picture1Name2 =
        '2${DateTime.now().millisecondsSinceEpoch}.png';
    try {
      var putfile = await firebase_storage.FirebaseStorage.instance
          .ref('/product_image')
          .child(picture1Name2)
          .putFile(_image2);
      var fileaUrl = await putfile.ref.getDownloadURL();
      _productModel.images.add(fileaUrl);
    } on Exception catch (e) {
      print(e.toString());
    }

    /////////////////////////////////////////////Imge 3

    final String picture1Name3 =
        '3${DateTime.now().millisecondsSinceEpoch.toString()}.png';
    try {
      var putfile = await firebase_storage.FirebaseStorage.instance
          .ref('/product_image')
          .child(picture1Name3)
          .putFile(_image3);
      var fileaUrl = await putfile.ref.getDownloadURL();
      _productModel.images.add(fileaUrl);
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
