import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/authServices.dart';
import 'package:flutter_ecom/controle/userEdit.dart';
import 'package:flutter_ecom/view/widgets.dart/appBar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

final imageState = StateProvider<File>((ref) {
  File value;
  return value;
});
final _isLoading = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class EditProfile extends ConsumerWidget {
  UserEdit editProfileControle = UserEdit();
  File image;
  final String uid;

  EditProfile({Key key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final picker = ImagePicker();
    final updateUserData = watch(authStatus.notifier);
    final watchImageState = watch(imageState);
    final loading = watch(_isLoading);

    Future getImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image = File(pickedFile.path);
        watchImageState.state = File(pickedFile.path);
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
      body: Stack(
        children: [
          Column(
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
                              backgroundImage: image != null
                                  ? FileImage(image)
                                  : NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/ecommerce-cbc61.appspot.com/o/cusom_images%2Fprofile%20image.png?alt=media&token=5be100b2-ac9c-4413-9c39-d1f947cddac1'),
                              maxRadius: 100,
                            )
                            // ClipOval(
                            //   child: image != null
                            //       ? Image(image: FileImage(image, scale: 9.0))
                            //       : Icon(Icons.camera_alt_sharp,
                            //           size: 60,
                            //           color: Theme.of(context).primaryColor),
                            // ),
                            ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Text('tap to chose image'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor)),
                            onPressed: () async {
                              assert(
                                  image != null,
                                  Fluttertoast.showToast(
                                      msg: 'Please chose an image!',
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      fontSize: 20,
                                      timeInSecForIosWeb: 3));
                              // await delying(context, loading);
                              await upDateProfileImage(context, loading);
                              //GET USER DETAILS AND UPDATE IT IN THE DRAWER
                              await updateUserData.updateUser();
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
          Visibility(
              visible: loading.state == true,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.7)),
                child: Center(
                  child: Container(
                    color: Colors.white,
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.red),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Future<void> upDateProfileImage(
      context, StateController<bool> loading) async {
    loading.state = true;
    try {
      if (!await editProfileControle.uploadProfileImage(
          image: image, uid: uid)) {
        Fluttertoast.showToast(
            msg: 'Failed',
            backgroundColor: Theme.of(context).primaryColor,
            fontSize: 20,
            timeInSecForIosWeb: 3);
      } else {
        Fluttertoast.showToast(
            msg: 'Done',
            backgroundColor: Theme.of(context).primaryColor,
            fontSize: 20,
            timeInSecForIosWeb: 3);
      }
      loading.state = false;
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
