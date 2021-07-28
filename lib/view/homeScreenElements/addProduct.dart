import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/brandGoryService.dart';
import 'package:flutter_ecom/controle/product_Services.dart';
import 'package:flutter_ecom/models/goryModel.dart';
import 'package:flutter_ecom/models/productModel.dart';
import 'package:flutter_ecom/view/common/constants.dart';
import 'package:flutter_ecom/view/common/userId.dart';
import 'package:flutter_ecom/view/common/uuid.dart';
import 'package:flutter_ecom/view/common/visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:circular_check_box/circular_check_box.dart';

final goryString = StateProvider<String>((ref) {
  String value;
  return value;
});

class AddProduct extends StatefulWidget {
  final ProductModel productModel;

  const AddProduct({this.productModel});
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String> sellectedProdutSizes = [];
  ProductctServices _productServices = ProductctServices();
  TextEditingController _detailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _qtyController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  String _productId;
  String _userId;
  String _category;
  List _colors;
  List _images;
  List _sizes;
  bool _sale;
  bool _feature;

  final _poductFormKey = GlobalKey<FormState>();
  bool _isLoading;

  //Image holder
  final picker = ImagePicker();
  //BRAND LIST VALUE
  String categoryvalue;
  File _image1;
  File _image2;
  File _image3;

  @override
  void initState() {
    _detailController.text = widget.productModel.detail;
    _nameController.text = widget.productModel.name;
    _qtyController.text = widget.productModel.qty.toString();
    _priceController.text = widget.productModel.price.toString();
    _brandController.text = widget.productModel.brand;
    _productId = widget.productModel.productId;
    _userId = widget.productModel.userid;
    _colors = widget.productModel.colors;
    _images = widget.productModel.images;
    _sizes = widget.productModel.sizes;
    _sale = widget.productModel.sale;
    _feature = widget.productModel.feature;
    _category = widget.productModel.category;
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _detailController.text = widget.productModel.detail;
    _nameController.text = widget.productModel.name;
    _qtyController.text = widget.productModel.qty.toString();
    _priceController.text = widget.productModel.price.toString();
    _brandController.text = widget.productModel.brand;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.close, color: Colors.white),
          onTap: () => Navigator.pop(context),
        ),
        elevation: 0,
        title: Text(
            _userId.characters.length < 3 ? 'Creat Products' : 'Update Product',
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
                              imagePlaceHolder('image1'),
                              imagePlaceHolder('image2'),
                              imagePlaceHolder('image3'),
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
                                  Text('Featured'),
                                  Switch(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: featuredState(_feature),
                                      onChanged: (bool value) {
                                        setState(() {
                                          featuredAction(_feature);
                                        });
                                      })
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                              ),
                              Row(
                                children: [
                                  Text('Sale'),
                                  Switch(
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: saleState(_sale),
                                      onChanged: (bool value) {
                                        setState(() {
                                          saleAction(_sale);
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
                                updateName();
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
                              productDetailDialog(context, _detailController);
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
                                    // onChanged: _productQty(widget.productModel),
                                    keyboardType: TextInputType.number,
                                    // controller: _productQuantityController,
                                    onChanged: (newValue) {
                                      updateQty();
                                      // widget.productModel.qty =
                                      //     int.parse(newValue);
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
                                    // onChanged: (value) => _productPrice(widget.productModel),
                                    onChanged: (newValue) {
                                      updatePrice();
                                      // widget.productModel.price =
                                      //     double.parse(newValue);
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
                                      // onChanged: (value) => _productPrice(widget.productModel),
                                      onChanged: (newValue) {
                                        // widget.productModel.brand = newValue;
                                        updateBrand();
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
                                                  hint: Text('category'),
                                                  onChanged: (newValue) {
                                                    // updateCategory();
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
                                  await buildShowDialog(context, _colors);
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
                                  sellectSizes(context, _sizes);
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
                                    _userId.characters.length < 3
                                        ? 'Creeate'
                                        : 'Update ',
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

  void updateName() => widget.productModel.name = _nameController.text;
  void updateQty() {
    widget.productModel.qty = int.parse(_qtyController.text);
  }

  void updatePrice() =>
      widget.productModel.price = double.parse(_priceController.text);
  void updateBrand() => widget.productModel.brand = _brandController.text;
  // void updateColors() => widget.productModel.colors = _colors;
  // void updateImages() => widget.productModel.images;
  // void updateSizes() => widget.productModel.sizes = _sizes;
  // void updateSale() => widget.productModel.sale;
  // void updateFeature() => widget.productModel.feature;
  // void updateCategory() => widget.productModel.category;

  Future<void> productDetailDialog(
      BuildContext context, TextEditingController detailController) async {
    void updateDescription() =>
        widget.productModel.detail = detailController.text;
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
                controller: detailController,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    // detialController.text = value;
                    updateDescription();
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
                    detailController.clear();
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

  Future<void> buildShowDialog(BuildContext context, List colors) async {
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
                    value: colorState('Blue'),
                    // inactiveColor: Colors.blue,
                    activeColor: Colors.blue,
                    onChanged: (bool value) {
                      setState(() {
                        colors.contains('Blue')
                            ? removeColor('Blue')
                            : addColor('Blue');
                      });
                    }),
                Checkbox(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    value: colorState('Orange'),
                    fillColor: MaterialStateProperty.all(Colors.orange),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    // inactiveColor: Colors.orange,
                    activeColor: Colors.orange,
                    onChanged: (bool value) {
                      setState(() {
                        colors.contains('Orange')
                            ? removeColor('Orange')
                            : addColor('Orange');
                      });
                    }),
                Checkbox(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    value: colorState('Purple'),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    fillColor: MaterialStateProperty.all(Colors.purple),
                    // inactiveColor: Colors.purple,
                    activeColor: Colors.purple,
                    onChanged: (bool value) {
                      setState(() {
                        colors.contains('Purple')
                            ? removeColor('Purple')
                            : addColor('Purple');
                      });
                    }),
                Checkbox(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    value: colorState('Yellow'),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    fillColor: MaterialStateProperty.all(Colors.yellow),
                    // inactiveColor: Colors.yellow,
                    activeColor: Colors.yellow,
                    onChanged: (bool value) {
                      setState(() {
                        colors.contains('Yellow')
                            ? removeColor('Yellow')
                            : addColor('Yellow');
                      });
                    }),
                Checkbox(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    value: colorState('Pink'),
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    fillColor: MaterialStateProperty.all(Colors.pink),
                    // fillColor: MaterialStateProperty.resolveWith(Colors.pink),
                    activeColor: Colors.pink,
                    onChanged: (bool value) {
                      setState(() {
                        colors.contains('Pink')
                            ? removeColor('Pink')
                            : addColor('Pink');
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
  sellectSizes(context, List sizes) async {
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
  Future getImage(String image) async {
    try {
      var pickedFile = await picker.getImage(source: ImageSource.gallery);
      switch (image) {
        case 'image1':
          setState(() {
            _image1 = File(pickedFile.path);
          });
          break;
        case 'image2':
          setState(() {
            _image2 = File(pickedFile.path);
          });
          break;
        case 'image3':
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
  Widget image(String img, List fireStoreImage) {
    var displayImage;

    //IMAGE ONE
    if (img == 'image1') {
      if (_image1 == null && fireStoreImage.isEmpty) {
        setState(() {
          displayImage =
              Icon(Icons.camera_alt, color: Colors.grey.withOpacity(0.9));
        });
      } else if (_image1 == null && fireStoreImage.isNotEmpty) {
        setState(() {
          displayImage = Image.network(fireStoreImage[0]);
        });
      } else {
        setState(() {
          displayImage =
              Image.file(_image1, fit: BoxFit.fill, width: double.infinity);
        });
      }
    }

    //image 2
    if (img == 'image2') {
      if (_image2 == null && fireStoreImage.isEmpty) {
        setState(() {
          displayImage =
              Icon(Icons.camera_alt, color: Colors.grey.withOpacity(0.9));
        });
      } else if (_image2 == null && fireStoreImage.isNotEmpty) {
        setState(() {
          displayImage = Image.network(fireStoreImage[1]);
        });
      } else {
        setState(() {
          displayImage =
              Image.file(_image2, fit: BoxFit.fill, width: double.infinity);
        });
      }
    }
    //image 3
    if (img == 'image3') {
      if (_image3 == null && fireStoreImage.isEmpty) {
        setState(() {
          displayImage =
              Icon(Icons.camera_alt, color: Colors.grey.withOpacity(0.9));
        });
      } else if (_image3 == null && fireStoreImage.isNotEmpty) {
        setState(() {
          displayImage = Image.network(fireStoreImage[2]);
        });
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
  Widget imagePlaceHolder(
    String imgPickerWget,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => getImage(
          imgPickerWget,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            height: 100,
            width: 60,
            child: image(imgPickerWget, _images),
          ),
        ),
      ),
    );
  }

//ad prodct function
  Future addProduct(
    BuildContext context,
    ProductModel productModel,
  ) async {
    Map map = productModel.toMap();

    FormState formState = _poductFormKey.currentState;
    if (formState.validate()) {
      assert(
          _image1 != null && _image2 != null && _image3 != null,
          Fluttertoast.showToast(
              msg: 'Requress three product imgaes', backgroundColor: kRedColr));
      assert(
          productModel.category != null,
          Fluttertoast.showToast(
              msg: 'Reques product category', backgroundColor: kRedColr));
      assert(
          productModel.sizes.isNotEmpty,
          Fluttertoast.showToast(
              msg: 'Reques product sizes', backgroundColor: kRedColr));
      assert(
          productModel.colors.isNotEmpty,
          Fluttertoast.showToast(
              msg: 'Requires product colors', backgroundColor: kRedColr));
      setState(() {
        _isLoading = true;
      });
      //  await  Future.delayed(Duration(milliseconds: 10000));

      await uploadImage(productModel);
      if (productModel.productId == null) {
        map['userid'] = getUserid();
        map['productId'] = uuid1;
        await _productServices.updateProduct(map);
      } else {
        await _productServices.createProduct(map);
      }

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

  colorState(String value) {
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
  bool featuredState(bool featured) {
    if (!featured) {
      return false;
    } else {
      return true;
    }
  }

  featuredAction(bool featured) {
    if (featured == false) {
      _feature = true;
    } else {
      _feature = false;
    }
  }

  bool saleState(bool sale) {
    if (!sale) {
      return false;
    } else {
      return true;
    }
  }

  saleAction(bool sale) {
    if (sale == false) {
      _sale = true;
    } else {
      _sale = false;
    }
  }
}
