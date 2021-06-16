import 'package:firebase_auth/firebase_auth.dart';

String getUserid() {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String autState;
  if (_auth.currentUser != null) {
    autState = _auth.currentUser.uid.toString();
  }
  return autState;
}
