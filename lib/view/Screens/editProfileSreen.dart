import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/editProfileCont.dart';
import 'package:flutter_ecom/view/widgets.dart/appBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final String uid;

  const EditProfile({Key key, this.uid}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  EditProfileControle editProfileControle = EditProfileControle();
  File image;

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    Future getImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    }

    return Scaffold(
      appBar: appbar(context,
          home: 'nothome',
          search: 'notsearch',
          cart: 'notcart',
          add: 'notadd',
          store: 'notstore',
          favorite: 'notfavorite'),
      body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await getImage();
                      },
                      child: CircleAvatar(
                          maxRadius: 50,
                          backgroundImage: image != null
                              ? FileImage(image)
                              : CachedNetworkImageProvider(
                                  'https://firebasestorage.googleapis.com/v0/b/ecommerce-cbc61.appspot.com/o/cusom_images%2Fprofile%20image.png?alt=media&token=5be100b2-ac9c-4413-9c39-d1f947cddac1')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text('tap to chose image'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        style: ButtonStyle(),
                        onPressed: () async {
                          try {
                            assert(
                                image != null,
                                Fluttertoast.showToast(
                                    msg: 'Please chose an image!',
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    fontSize: 20,
                                    timeInSecForIosWeb: 3));
                            if (!await editProfileControle.uploadProfileImage(
                                image: image, uid: widget.uid)) {
                              Fluttertoast.showToast(
                                  msg: 'Failed',
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  fontSize: 20,
                                  timeInSecForIosWeb: 3);
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Done',
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  fontSize: 20,
                                  timeInSecForIosWeb: 3);
                              Navigator.pop(context);
                            }
                          } on Exception catch (e) {
                            print(e.toString());
                          }
                        },
                        child: Text(
                          'Update',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}
