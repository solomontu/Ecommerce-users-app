import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecom/dp/authServices.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_ecom/molels/userModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'myHomePage.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  final errorMessage;

  const Login({Key key, this.errorMessage}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final model = UserModel();

  SharedPreferences sharedPreferences;
  //shared prefferene is rused to know if one has ever loged in to the app
  //by saving the user basic infos on the device
  bool loading = false;
  bool isLogedIn = false;

  final _formKeyLogIn = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final minimumPadding = 10.0;

//google signIn handler on compilation time
  @override
  void initState() {
    emailController.text = model.email;
    passwordController.text = model.passWord;
    isUserLogedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //   image: AssetImage('Assets/images/singleImages/BackGimage.jpg'),
        //   fit: BoxFit.cover,
        // )),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              // color: Colors.black.withOpacity(0.4)
            ),
            ListView(
              children: <Widget>[
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage(
                                'Assets/images/singleImages/lg.png'))),
                  ),
                ),
                Form(
                    key: _formKeyLogIn,
                    child: Column(
                      children: <Widget>[
                        //EMAIL FIELD SETTINGS
                        Padding(
                          padding: EdgeInsets.only(
                              // top: minimumPadding -5,
                              bottom: minimumPadding,
                              left: minimumPadding,
                              right: minimumPadding),
                          child: Material(
                            elevation: 20,
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              onChanged: (value) {
                                emailer();
                              },
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // borderSide:
                                  //     BorderSide(color: Colors.pinkAccent)
                                ),
                                prefixIcon: Icon(Icons.alternate_email),
                                // alignLabelWithHint: true,
                                labelText: 'Email or Phone',
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
                        ),

                        // PASSWORD FIELD SETTINGS
                        Padding(
                          padding: EdgeInsets.only(
                              left: minimumPadding, right: minimumPadding),
                          child: Material(
                            elevation: 20,
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                            child: TextFormField(
                              onChanged: (value) {
                                passworder();
                              },
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // borderSide:
                                  //     BorderSide(color: Colors.pinkAccent)
                                ),
                                prefixIcon: Icon(Icons.lock_outline),
                                labelText: 'Password',
                              ),
                              validator: (input) {
                                if (input.isEmpty) {
                                  return "Empty field";
                                }
                                if (input.length < 6) {
                                  return 'Your password must have at least 6 characters';
                                }
                                return null;
                              },
                              // onSaved: (input) => _passWord = input.trim(),
                            ),
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: minimumPadding, horizontal: minimumPadding),
                  child: MaterialButton(
                    // textColor: Colors.black,

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),

                    onPressed: () {
                      signInEmailPassword();
                    },

                    color: Colors.pink,
                    child: Text(
                      'Signin',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          letterSpacing: 2.0),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {},
                        child: RichText(
                          text: TextSpan(
                            text: 'Forgot password',
                            style: TextStyle(
                                // fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                          textAlign: TextAlign.center,
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Creat an account',
                            style: TextStyle(
                                // fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Or',
                    style: TextStyle(fontSize: 27),
                    textAlign: TextAlign.center,
                  ),
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
            Visibility(
                visible: loading ?? true,
                child: Center(
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.7)),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.red),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  emailer() => model.email = emailController.text;
  passworder() => model.passWord = passwordController.text;

  isUserLogedIn() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      setState(() {
        loading = true;
      });
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      }
      setState(() {
        loading = false;
      });
    });
  }

  signInEmailPassword() async {
    FormState formState = _formKeyLogIn.currentState;
    if (formState.validate()) {
      await Firebase.initializeApp();
      setState(() {
        loading = true;
      });
     AuthWithEmailPassword authWithEmailPassword = AuthWithEmailPassword(
        email: model.email,
        password: model.passWord,
      );

      await authWithEmailPassword.signInAuthentic();
      if (widget.errorMessage == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
        Fluttertoast.showToast(msg: widget.errorMessage);
      }
    }
  }
}
