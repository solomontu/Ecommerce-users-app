import 'package:flutter/material.dart';

class ActorFilterEntry {
  const ActorFilterEntry(this.name, this.initials);
  final String name;
  final String initials;
}

class CastFilter extends StatefulWidget {
  @override
  State createState() => CastFilterState();
}

class CastFilterState extends State<CastFilter> {
  final List<ActorFilterEntry> _cast = <ActorFilterEntry>[
    const ActorFilterEntry('Aaron Burr', 'AB'),
    const ActorFilterEntry('Alexander Hamilton', 'AH'),
    const ActorFilterEntry('Eliza Hamilton', 'EH'),
    const ActorFilterEntry('James Madison', 'JM'),
  ];
  List<String> _filters = <String>[];

  Iterable<Widget> get actorWidgets sync* {
    for (final ActorFilterEntry actor in _cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          avatar: CircleAvatar(child: Text(actor.initials)),
          label: Text(actor.name),
          selected: _filters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(actor.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == actor.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          children: actorWidgets.toList(),
        ),
        Text('Look for: ${_filters.join(', ')}'),
      ],
    );
  }
}

// // CHECK IF THE USER IS ALREADY SIGNED IN WITH GOOGLE
//   void isSignedIn() async {
//     setState(() {
//       loading = true;
//     });
//     sharedPreferences = await SharedPreferences.getInstance();
//     isLogedIn = await _googleSignIn.isSignedIn();
//     if (isLogedIn) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => MyHomePage()));
//     }

//     setState(() {
//       loading = false;
//     });
//   }

// //if the user is not signed in, then use google to sign in
//   handleGoogleSignIn() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//       loading = true;
//     });
//     GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//     GoogleSignInAuthentication googleAuth = await googleUser.authentication;

// //check if the user already has a google account
//     final AuthCredential credential = GoogleAuthProvider.getCredential(
//         idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

//     final FirebaseUser firebaseUser =
//         (await _auth.signInWithCredential(credential)).user;

//     //query the database if he already has an accoutn your the application
//     if (firebaseUser != null) {
//       final QuerySnapshot result = await Firestore.instance
//           .collection('students')
//           .where('id', isEqualTo: firebaseUser.uid)
//           .getDocuments();
//       //if the user doesn't exist, create account;
//       final List<DocumentSnapshot> document = result.documents;

//       if (document.length == 0) {
//         Firestore.instance
//             .collection('students')
//             .document(firebaseUser.uid)
//             .setData({
//           'ID': firebaseUser.uid,
//           'userName': firebaseUser.displayName,
//           'email': firebaseUser.email,
//           'profilePicture': firebaseUser.photoUrl
//         });
//         await sharedPreferences.setString('id', firebaseUser.uid);
//         await sharedPreferences.setString('userName', firebaseUser.displayName);
//         await sharedPreferences.setString('phoUrl', firebaseUser.photoUrl);
//         //if the user exist, then
//       } else {
//         await sharedPreferences.setString('id', document[0]['id']);
//         await sharedPreferences.setString('userName', document[0]['userName']);
//         await sharedPreferences.setString('phoUrl', document[0]['phoUrl']);
//       }
//       Fluttertoast.showToast(msg: 'Login successful');
//       setState(() {
//         loading = false;
//       });
//     } else {}
//   }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class LogaIn extends StatefulWidget {
//   @override
//   _LogaInState createState() => _LogaInState();
// }

// class _LogaInState extends State<LogaIn> {
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   GoogleSignIn googleSignIn = GoogleSignIn();
//   SharedPreferences sharedPreferences;
//   bool loading = false;
//   bool isLogedIn = false;

//   @override
//   void initState() {
//     isSignedIn();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }

//   void isSignedIn() async {
//     setState(() {
//       loading = true;
//     });
//     sharedPreferences = await SharedPreferences.getInstance();
//     isLogedIn = await googleSignIn.isSignedIn();
//     if (isLogedIn) {

//     }
//   }
// }
