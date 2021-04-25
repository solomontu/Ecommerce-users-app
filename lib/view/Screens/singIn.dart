import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/authServices.dart';
import 'package:flutter_ecom/view/common/loading.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'signup.dart';
// import '../dp/authServices.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final model = UserModel();

  final _formKeyLogIn = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final minimumPadding = 10.0;

//google signIn handler on compilation time
  // @override
  // void initState() {
  //   _email.text = model.email;
  //   _password.text = model.passWord;
  //   super.initState();
  // }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<AuthWithEmailPassword>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: _user.status == Status.authenticating
          ? Center(child: Loadng())
          : Center(
        child: SingleChildScrollView(
          child: Form(key: _formKeyLogIn,
            child: Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // margin: EdgeInsets.only(top: 20),
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
                      // onChanged: (value) {
                      //   passworder();
                      // },
                      controller: _password,
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
                        } else if (input.length < 6) {
                          return 'Your password must have at least 6 characters';
                        }
                        return null;
                      },
                      // onSaved: (input) => _passWord = input.trim(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: minimumPadding, horizontal: minimumPadding),
                  child: MaterialButton(
                    // textColor: Colors.black,

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),

                    onPressed: () async {
                      // AuthWithEmailPassword(
                      //   email: model.email,
                      //   password: model.passWord,
                      // );
                      assert(_formKeyLogIn.currentState.validate() == true);

                      if (!await _user.signInAuthentic(
                          emaill: _email.text, passwordd: _password.text)) {
                        Fluttertoast.showToast(msg: _user.error.toString());
                        // _scaffoldKey.currentState.showSnackBar(SnackBar(
                        //   content: Text(_user.error),
                        // ));
                      }
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
