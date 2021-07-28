import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/brandGoryService.dart';
import 'package:flutter_ecom/controle/product_Services.dart';
import 'package:flutter_ecom/models/goryModel.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/common/constants.dart';
import 'package:flutter_ecom/view/common/userId.dart';
import 'package:flutter_ecom/view/common/visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';
// import 'package:circular_check_box/circular_check_box.dart';

final goryString = StateProvider<String>((ref) {
  String value;
  return value;
});

class AddProduct extends StatefulWidget {
  final ProductModel productModel;

  const AddProduct({
    Key key,
    this.productModel,
  }) : super(key: key);
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String> sellectedProdutSizes = [];
  ProductctServices _productServices = ProductctServices();
  // ProductModel _productModel = ProductModel();
  final _poductFormKey = GlobalKey<FormState>();
  bool _isLoading;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _detialController = TextEditingController();
  TextEditingController _qtyController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  String _productId;
  String _userid;
  List _colors;
  List _images;
  List _sizes;
  bool _sale;
  bool _featured;
  int _qty;

  //Image holder
  final picker = ImagePicker();
  //BRAND LIST VALUE
  String categoryvalue;
  File _image1;
  File _image2;
  File _image3;

  @override
  void initState() {
    _nameController.text = widget.productModel.name;
    _detialController.text = widget.productModel.detail;
    _qtyController.text = widget.productModel.qty.toString();
    _priceController.text = widget.productModel.price.toString();
    _brandController.text = widget.productModel.brand;
    _productId = widget.productModel.productId;
    _userid = widget.productModel.userid;
    _colors = widget.productModel.colors;
    _sizes = widget.productModel.sizes;
    _images = widget.productModel.images;
    _featured = widget.productModel.feature;
    _sale = widget.productModel.sale;

    _isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detialController.dispose();
    _qtyController.dispose();
    _priceController.dispose();
    _brandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.productModel.name;
    _detialController.text = widget.productModel.detail;
    _qtyController.text = widget.productModel.qty.toString();
    _priceController.text = widget.productModel.price.toString();
    _brandController.text = widget.productModel.brand;
    _productId = widget.productModel.productId;
    _userid = widget.productModel.userid;
    _colors = widget.productModel.colors;
    _sizes = widget.productModel.sizes;
    _images = widget.productModel.images;
    _featured = widget.productModel.feature;
    _sale = widget.productModel.sale;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.close, color: Colors.white),
          onTap: () => Navigator.pop(context),
        ),
        elevation: 0,
        title: Text(
            widget.productModel.productId.characters.length < 5
                ? 'Create Product'
                : 'Update Product',
            style: TextStyle(
                color: Colors.white, letterSpacing: 2.0, fontSize: 25)),
        backgroundColor: Theme.of(context).primaryColor,
      ),

      //porduct attribute
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _poductFormKey,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              imagePlaceHolder('image1', widget.productModel),
                              imagePlaceHolder('_image2', widget.productModel),
                              imagePlaceHolder('_image3', widget.productModel),
                            ],
                          ),
                        ),
                      ),

                      Expanded(
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text('Featured',
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                  Switch(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: featuredState(_featured),
                                      onChanged: (bool value) {
                                        setState(() {
                                          featuredAction(_featured);
                                        });
                                      })
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                              ),
                              Row(
                                children: [
                                  Text('Sale',
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                  Switch(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: saleState(),
                                      onChanged: (bool value) {
                                        setState(() {
                                          saleAction();
                                        });
                                      })
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                              ),
                            ],
                          ),
                        ),
                      ),

                      //product name
                      Expanded(
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextFormField(
                              controller: _nameController,
                              onChanged: (value) {
                                setState(() {
                                  updateName();
                                });
                                // _productModel.name = value;
                              },
                              maxLength: 20,
                              validator: (value) =>
                                  value.isEmpty ? 'Name is requred' : null,
                              decoration: InputDecoration(
                                hintText: 'Name',
                              ),
                            ),
                          ),
                        ),
                      ),

                      //PRODUCT DESCRIPTION
                      Expanded(
                        child: SizedBox(
                          child: InkWell(
                            onTap: () {
                              productDetailDialog(
                                context,
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Detals',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Divider(
                                      // height: 5,
                                      thickness: 1.0,
                                      color: Colors.grey[500]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      //pruoduct quantity and procice
                      Expanded(
                        child: SizedBox(
                          child: Row(
                            // mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextFormField(
                                    controller: _qtyController,
                                    keyboardType: TextInputType.number,
                                    onChanged: (newValue) {
                                      // _productModel.qty = int.parse(newValue);
                                      setState(() {
                                        updateQty();
                                      });
                                    },
                                    maxLength: 10,
                                    validator: (value) => value.isEmpty
                                        ? 'Quantity is required'
                                        : null,
                                    decoration: InputDecoration(
                                      hintText: 'Qty',
                                    ),
                                  ),
                                ),
                              ),
                              //Product price
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _priceController,
                                    onChanged: (newValue) {
                                      // _productModel.price =
                                      //     double.parse(newValue);
                                      setState(() {
                                        updatePrice();
                                      });
                                    },
                                    maxLength: 10,
                                    validator: (value) => value.isEmpty
                                        ? 'Price is required'
                                        : null,
                                    decoration: InputDecoration(
                                      hintText: 'Price',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Expanded(
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //category listTile;
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: TextFormField(
                                      controller: _brandController,
                                      // onChanged: (value) => _productPrice(_productModel),
                                      onChanged: (newValue) {
                                        // _productModel.brand = newValue;
                                        setState(() {
                                          updateBrand();
                                        });
                                      },

                                      validator: (value) => value.isEmpty
                                          ? 'Brandis required'
                                          : null,
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
                                        child: Consumer(builder:
                                            (BuildContext context, watch,
                                                Widget child) {
                                          AsyncValue<List<GoryModel>> stream =
                                              watch(goryStream);
                                          final goryValue = watch(goryString);
                                          return stream.when(
                                            data: (data) => SizedBox(
                                              height: 30,
                                              child: DropdownButton(
                                                  isExpanded: false,
                                                  isDense: false,
                                                  dropdownColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                  underline: SizedBox(),
                                                  value: goryValue.state,

                                                  // isExpanded: true,
                                                  hint: Text('Category'),
                                                  onChanged: (newValue) {
                                                    widget.productModel
                                                        .category = newValue;
                                                    goryValue.state = newValue;
                                                  },
                                                  items: data
                                                      .map<DropdownMenuItem>(
                                                          (value) {
                                                    return DropdownMenuItem<
                                                            String>(
                                                        value: value.gory,
                                                        child: Text(value.gory,
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .lightBlueAccent,
                                                            )));
                                                  }).toList()),
                                            ),
                                            loading: () =>
                                                LinearProgressIndicator(),
                                            error: (err, stack) => Center(
                                                child: Text(err.toString())),
                                          );
                                        }))),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //MATERIAL BUTTON FOR SIZES dialogue
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: OutlinedButton(
                                onPressed: () async {
                                  await buildShowDialog(
                                      context, widget.productModel.colors);
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
                                  sellectSizes(widget.productModel.sizes);
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
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),

                                  color: Theme.of(context).primaryColorDark,
                                  child: Text(
                                    widget.productModel.productId.characters
                                                .length <
                                            5
                                        ? 'Create'
                                        : 'Update',
                                    style: TextStyle(
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        letterSpacing: 2.0),
                                  ),
                                  //AD PRODUCT
                                  onPressed: () async {
                                    addProduct(context, widget.productModel);
                                  },
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          visibility(context: context, value: _isLoading)
        ],
      ),
    );
  }

  void updateName() => widget.productModel.detail = _detialController.text;
  void updateQty() => widget.productModel.detail = _detialController.text;
  void updatePrice() => widget.productModel.detail = _detialController.text;
  void updateBrand() => widget.productModel.detail = _detialController.text;
  void updateDetail() => widget.productModel.detail = _detialController.text;

  Future<void> productDetailDialog(
    BuildContext context,
    // ProductModel _productModel,
    // TextEditingController _detialController
  ) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Product description',
              style: TextStyle(color: Colors.white),
            ),
            content: StatefulBuilder(builder: (context, StateSetter setState) {
              return TextField(
                controller: _detialController,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    updateDetail();
                  });
                },
                textCapitalization: TextCapitalization.sentences,
                maxLines: 12,
                maxLength: 300,
                cursorColor: Colors.white,
                enableInteractiveSelection: true,
                enableSuggestions: true,
                autofocus: false,
                enabled: true,
                textAlign: TextAlign.justify,

                // validator: (value) =>
                //     value.isEmpty ? 'Deiscripion is requred' : null,
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
                    _detialController.clear();
                  },
                  child: Text(
                    'Clear',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () {
                    // print(sellectedProdutSizes.length);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ],
            actionsPadding: EdgeInsets.symmetric(horizontal: 30.0),
          );
        });
  }

  Future<void> buildShowDialog(
      BuildContext context, List<String> colors) async {
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
                    fillColor: MaterialStateProperty.all(Colors.blue),
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    value: checkBoxState('blue'),
                    // inactiveColor: Colors.blue,
                    activeColor: Colors.blue,
                    onChanged: (bool value) {
                      setState(() {
                        colors.contains('blue')
                            ? removeColor('blue')
                            : addColor('blue');
                      });
                    }),
                Checkbox(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    value: checkBoxState('orange'),
                    fillColor: MaterialStateProperty.all(Colors.orange),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    // inactiveColor: Colors.orange,
                    activeColor: Colors.orange,
                    onChanged: (bool value) {
                      setState(() {
                        colors.contains('orange')
                            ? removeColor('orange')
                            : addColor('orange');
                      });
                    }),
                Checkbox(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    value: checkBoxState('purple'),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    fillColor: MaterialStateProperty.all(Colors.purple),
                    // inactiveColor: Colors.purple,
                    activeColor: Colors.purple,
                    onChanged: (bool value) {
                      setState(() {
                        colors.contains('purple')
                            ? removeColor('purple')
                            : addColor('purple');
                      });
                    }),
                Checkbox(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    value: checkBoxState('yellow'),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    fillColor: MaterialStateProperty.all(Colors.yellow),
                    // inactiveColor: Colors.yellow,
                    activeColor: Colors.yellow,
                    onChanged: (bool value) {
                      setState(() {
                        colors.contains('yellow')
                            ? removeColor('yellow')
                            : addColor('yellow');
                      });
                    }),
                Checkbox(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    value: checkBoxState('pink'),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    fillColor: MaterialStateProperty.all(Colors.pink),
                    // fillColor: MaterialStateProperty.resolveWith(Colors.pink),
                    activeColor: Colors.pink,
                    onChanged: (bool value) {
                      setState(() {
                        colors.contains('pink')
                            ? removeColor('pink')
                            : addColor('pink');
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
  sellectSizes(List<String> sizes) async {
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
                      Flexible(
                          child: Text('XS',
                              style: TextStyle(color: Colors.white))),
                      Flexible(
                        child: Checkbox(
                            fillColor: MaterialStateProperty.all(Colors.white),
                            checkColor: Theme.of(context).primaryColor,
                            value: sizeCheckState('XS'),
                            onChanged: (value) {
                              setState(() {
                                sizes.contains('XS')
                                    ? removeSize('XS')
                                    : addSize('XS');
                              });
                            }),
                      ),
                      Flexible(
                          child:
                              Text('S', style: TextStyle(color: Colors.white))),
                      Flexible(
                        child: Checkbox(
                            fillColor: MaterialStateProperty.all(Colors.white),
                            checkColor: Theme.of(context).primaryColor,
                            value: sizeCheckState('S'),
                            onChanged: (value) {
                              setState(() {
                                sizes.contains('S')
                                    ? removeSize('S')
                                    : addSize('S');
                              });
                            }),
                      ),
                      Flexible(
                          child:
                              Text('M', style: TextStyle(color: Colors.white))),
                      Flexible(
                        child: Checkbox(
                            fillColor: MaterialStateProperty.all(Colors.white),
                            checkColor: Theme.of(context).primaryColor,
                            value: sizeCheckState('M'),
                            onChanged: (value) {
                              setState(() {
                                sizes.contains('M')
                                    ? removeSize('M')
                                    : addSize('M');
                              });
                            }),
                      ),
                    ],
                  ),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                          child:
                              Text('L', style: TextStyle(color: Colors.white))),
                      Flexible(
                        child: Checkbox(
                            fillColor: MaterialStateProperty.all(Colors.white),
                            checkColor: Theme.of(context).primaryColor,
                            value: sizeCheckState('L'),
                            onChanged: (value) {
                              setState(() {
                                sizes.contains('L')
                                    ? removeSize('L')
                                    : addSize('L');
                              });
                            }),
                      ),
                      Flexible(
                          child: Text('XL',
                              style: TextStyle(color: Colors.white))),
                      Flexible(
                        child: Checkbox(
                            fillColor: MaterialStateProperty.all(Colors.white),
                            checkColor: Theme.of(context).primaryColor,
                            value: sizeCheckState('XL'),
                            onChanged: (value) {
                              setState(() {
                                sizes.contains('XL')
                                    ? removeSize('XL')
                                    : addSize('XL');
                              });
                            }),
                      ),
                      Flexible(
                          child: Text('XXL',
                              style: TextStyle(color: Colors.white))),
                      Flexible(
                        child: Checkbox(
                            fillColor: MaterialStateProperty.all(Colors.white),
                            checkColor: Theme.of(context).primaryColor,
                            value: sizeCheckState('XXL'),
                            onChanged: (value) {
                              setState(() {
                                sizes.contains('XXL')
                                    ? removeSize('XXL')
                                    : addSize('XXL');
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
  Future addProduct(
    BuildContext context,
    ProductModel _productModel,
  ) async {
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
      setState(() {
        _isLoading = true;
      });
      //  await  Future.delayed(Duration(milliseconds: 10000));

      await uploadImage(_productModel);
      await _productServices.createProduct(map);
      setState(() {
        _isLoading = false;
      });
      formState.reset();
      Fluttertoast.showToast(msg: 'Product added', backgroundColor: kRedColr);
      Navigator.pop(context);
    }
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
      widget.productModel.images.add(fileaUrl);
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
      widget.productModel.images.add(fileaUrl);
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
      widget.productModel.images.add(fileaUrl);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  //FUNCTIONS
  addColor(String color) {
    if (widget.productModel.colors.contains(color) == false) {
      _colors.add(color);
    }
  }

  removeColor(String color) {
    if (widget.productModel.colors.contains(color) == true) {
      _colors.remove(color);
    }
  }

  checkBoxState(String value) {
    if (widget.productModel.colors.contains(value)) {
      return true;
    } else {
      return false;
    }
  }

  //ADD SIZES
  addSize(String size) {
    if (_sizes.contains(size) == false) {
      _sizes.add(size);
    }
  }

  removeSize(String size) {
    if (_sizes.contains(size) == true) {
      _sizes.remove(size);
    }
  }

  sizeCheckState(String value) {
    if (_sizes.contains(value)) {
      return true;
    } else {
      return false;
    }
  }

//FEATURESTATE
  bool featuredState(bool _featured) {
    if (_featured) {
      return true;
    } else {
      return false;
    }
  }

  featuredAction(bool _featured) {
    if (_featured) {
      _featured = false;
    } else {
      _featured = true;
    }
  }

  bool saleState() {
    if (!widget.productModel.sale) {
      return false;
    } else {
      return true;
    }
  }

  saleAction() {
    if (widget.productModel.sale) {
      _sale = false;
    } else {
      _sale = true;
    }
  }
}
