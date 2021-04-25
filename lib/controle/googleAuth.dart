// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import 'package:firebase_auth/firebase_auth.dart';

// abstract class GoogleAuthServices {
//   authenticate();
// }

// class HandleSignUp implements GoogleAuthServices {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   GoogleSignInAccount _currentUser;
//   @override
//   Future<User> authenticate() async {
//     GoogleSignIn _googleSignIn = GoogleSignIn(
//       scopes: [
//         'email',
//         'https://www.googleapis.com/auth/contacts.readonly',
//       ],
//     );
//     final Future<GoogleSignInAccount> googAccount = _googleSignIn.signIn();
//     // final GoogleSignInAuthentication googleAuth = await googAccount.;
//   }
// }

// class HandleSignIn implements GoogleAuthServices {
//   @override
//   authenticate() {
//     // TODO: implement authenticate
//     throw UnimplementedError();
//   }
// }
