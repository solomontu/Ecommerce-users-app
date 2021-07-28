import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/authServices.dart';
import 'package:flutter_ecom/view/Screens/myHomePage.dart';
import 'package:flutter_ecom/view/common/flutterToast.dart';
import 'package:flutter_ecom/view/common/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_ecom/view/Screens/signup.dart';
// import 'signup.dart';
// import '../dp/authServices.dart';

class Login extends ConsumerWidget {
  // final model = UserModel();

  final _formKeyLogIn = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final minimumPadding = 10.0;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Status status = watch(authStatus);
    AuthWithEmailPassword others = watch(authStatus.notifier);
    final hidepassword = watch(passWordVisbility);

    return Scaffold(
      key: _scaffoldKey,
      body: Card(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKeyLogIn,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 15),
                        child: Text(
                          'Signin',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              letterSpacing: 4),
                        ),
                      ),

                      //EMAIL FIELD SETTINGS
                      Padding(
                        padding: EdgeInsets.only(
                            // top: minimumPadding -5,
                            bottom: minimumPadding,
                            left: minimumPadding,
                            right: minimumPadding),
                        child: TextFormField(
                          // onChanged: (value) {
                          //   emailer();
                          // },
                          keyboardType: TextInputType.emailAddress,
                          controller: _email,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              // borderSide:
                              //     BorderSide(color: Colors.pinkAccent)
                            ),
                            prefixIcon: Icon(Icons.alternate_email),
                            // alignLabelWithHint: true,
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'empty field';
                            }
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(value)) {
                              return 'Invalid email address';
                            } else
                              return null;
                          },
                          // onSaved: (input) => _email = input.trim(),
                        ),
                      ),

                      // PASSWORD FIELD SETTINGS
                      Padding(
                        padding: EdgeInsets.only(
                            left: minimumPadding, right: minimumPadding),
                        child: TextFormField(
                          // onChanged: (value) {
                          //   passworder();
                          // },
                          controller: _password,
                          obscureText: hidepassword.state,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              // borderSide:
                              //     BorderSide(color: Colors.pinkAccent)
                            ),
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: GestureDetector(
                                child: Icon(Icons.remove_red_eye,
                                    color: hidepassword.state
                                        ? Colors.grey
                                        : Theme.of(context).primaryColor),
                                onTap: () => hidepassword.state
                                    ? hidepassword.state = false
                                    : hidepassword.state = true),
                            labelText: 'Password',
                          ),
                          validator: (input) {
                            if (input.isEmpty) {
                              return "Empty field";
                            } else if (input.length < 6) {
                              return 'Your password must have at least 6 characters';
                            }
                            return null;
                          },
                          // onSaved: (input) => _passWord = input.trim(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: minimumPadding,
                            horizontal: minimumPadding),
                        child: MaterialButton(
                          // textColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),

                          onPressed: () async {
                            // AuthWithEmailPassword(
                            //   email: model.email,
                            //   password: model.passWord,
                            // );
                            assert(
                                _formKeyLogIn.currentState.validate() == true);
                            // assert(await others.chekNetwork() == true,
                            //     await toast(msg: 'No network'));
                            var event = await others.signInAuthentic(
                                emaill: _email.text, passwordd: _password.text);

                            if (event == true) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MyHomePage()));
                            } else {
                              await toast(msg: others.message.toString());
                            }
                          },

                          color: Theme.of(context).primaryColorDark,
                          child: Text(
                            'Signin',
                            style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 2.0),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'Forgot password',
                              style: TextStyle(letterSpacing: 1.5),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text(
                              'Creat an account',
                              style: TextStyle(letterSpacing: 1.5),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Or',
                        style: TextStyle(
                            color: Colors.black54, letterSpacing: 1.5),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: minimumPadding),
                              child: InkWell(
                                onTap: () {
                                  // Do stuff here;
                                },
                                child: Container(
                                  child: SvgPicture.asset(
                                    'Assets/images/singleImages/facebook-logo@logotyp.us.svg',
                                    width: 40,
                                    height: 60,
                                  ),
                                  // alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: minimumPadding, bottom: minimumPadding),
                              child: InkWell(
                                onTap: () {},
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(
                                      'Assets/images/singleImages/ggg.png'),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: status == Status.authenticating,
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white30,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          color: Colors.white,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white70,
                          ),
                        ),
                      ))))
            ],
          ),
        ),
      ),
    );
  }

// emailer() => model.email = _email.text;
// passworder() => model.passWord = _password.text;

// isUserLogedIn() async {
//   await Firebase.initializeApp();

//   FirebaseAuth.instance.authStateChanges().listen((User user) {
//     setState(() {
//       loading = true;
//     });
//     if (user != null) {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => MyHomePage()));
//     }
//     setState(() {
//       loading = false;
//     });
//   });
// }

}
