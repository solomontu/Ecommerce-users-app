import 'package:flutter/material.dart';
import 'package:flutter_ecom/molels/userModel.dart';
import 'package:flutter_ecom/dp/authServices.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'myHomePage.dart';

class SignUp extends StatefulWidget {
  final errorMessage;

  const SignUp({Key key, this.errorMessage}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

enum GenderCharacter { male, female, others }

class _SignUpState extends State<SignUp> {
  final model = UserModel();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final surNameController = TextEditingController();
  final _formKeySignUp = GlobalKey<FormState>();

  // final model = model();
  int birthDayDropValue;
  int birthMonthDropValue;
  int birthYearDopValue;
  String genderString;
  bool validDate = false;
  bool loading = false;
  bool isLogedIn = false;
  bool hidepassword = true; /*for hiding the passeord with red_eye_icon*/
  bool _initialized = false;
  bool _error = false;

  SharedPreferences sharedPreferences;
  GenderCharacter _character;
  final minimumPadding = 10.0;

  var now = new DateTime.now();
  var berlinWallFell = new DateTime.utc(1989, 11, 9);

  @override
  void initState() {
    firstNameController.text = model.firstName;
    surNameController.text = model.surName;
    emailController.text = model.email;
    passwordController.text = model.passWord;
    birthDayDropValue = now.day;
    birthMonthDropValue = now.month;
    birthYearDopValue = now.year;

    initializeFlutterFire();
    // isSignedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            ListView(
              children: <Widget>[
                Form(
                    key: _formKeySignUp,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        //First name
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              minimumPadding, 10, minimumPadding, 2.5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300]),
                          padding: EdgeInsets.only(
                              bottom: 2,
                              left: minimumPadding / 2,
                              right: minimumPadding / 2,
                              top: 2),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: firstNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.person),
                              // alignLabelWithHint: true,
                              hintText: 'First name',
                            ),
                            validator: (input) {
                              if (input.isEmpty) {
                                return "enter your name";
                              } else if (input.length < 2) {
                                return "name too short";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              firstNameContModel();
                            },
                          ),
                        ),

                        //Last Name
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              minimumPadding, 2.5, minimumPadding, 2.5),
                          padding: EdgeInsets.only(
                              bottom: 2,
                              left: minimumPadding / 2,
                              right: minimumPadding / 2,
                              top: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300]),
                          child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: surNameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.person_outline),
                                // alignLabelWithHint: true,
                                hintText: 'Surname',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'enater your surname';
                                }

                                return null;
                              },
                              onChanged: (value) {
                                surNameContModel();
                              }),
                        ),

                        //EMAIL FIELD SETTINGS
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              minimumPadding, 2.5, minimumPadding, 2.5),
                          padding: EdgeInsets.only(
                              bottom: 2,
                              left: minimumPadding / 2,
                              right: minimumPadding / 2,
                              top: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300]),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.alternate_email),
                              // alignLabelWithHint: true,
                              hintText: 'Email or phone',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'enter your email';
                              }
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = new RegExp(pattern);
                              if (!regex.hasMatch(value))
                                return 'Invalid email address';
                              else
                                return null;
                            },
                            onChanged: (value) {
                              emailContModel();
                            },
                          ),
                        ),

                        // PASSWORD FIELD SETTINGS
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              minimumPadding, 2.5, minimumPadding, 2.5),
                          padding: EdgeInsets.only(
                              bottom: 2,
                              left: minimumPadding / 2,
                              right: minimumPadding / 2,
                              top: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300]),
                          child: TextFormField(
                            obscureText: hidepassword,
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: GestureDetector(
                                child: Icon(Icons.remove_red_eye,
                                    color: hidepassword == true
                                        ? Colors.grey
                                        : Theme.of(context).primaryColor),
                                onTap: () => setState(() {
                                  if (hidepassword == true) {
                                    hidepassword = false;
                                  } else if (hidepassword == false) {
                                    hidepassword = true;
                                  }
                                  // hidepassword;
                                }),
                                onDoubleTap: () => setState(() {
                                  hidepassword = hidepassword = true;
                                }),
                              ),
                              hintText: 'Password',
                            ),
                            validator: (input) {
                              if (input.isEmpty) {
                                return "enter your password";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              passwordContModel();
                            },
                          ),
                        ),

                        //================ RADIO BUTTON ============= =======================
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: minimumPadding,
                          ),
                          child: Container(
                            color: Colors.grey[300],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                //Genders column
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Gender',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            //MALE
                                            Column(
                                              children: <Widget>[
                                                Radio(
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    value: GenderCharacter.male,
                                                    groupValue: _character,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _character = value;
                                                        genderStringValue(
                                                            _character);
                                                      });
                                                    }),
                                                Text('m',
                                                    style: TextStyle(
                                                        color: Colors.black54))
                                              ],
                                            ),
                                            //FEAMLE
                                            Column(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Radio(
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    value:
                                                        GenderCharacter.female,
                                                    groupValue: _character,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _character = value;

                                                        genderStringValue(
                                                            _character);
                                                      });
                                                    }),
                                                Text('f',
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ))
                                              ],
                                            ),
                                            //OTHERS
                                            Column(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Radio(
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    value:
                                                        GenderCharacter.others,
                                                    groupValue: _character,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _character = value;
                                                        genderStringValue(
                                                            _character);
                                                      });
                                                    }),
                                                Text('o',
                                                    style: TextStyle(
                                                        color: Colors.black54)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),

                                // ================Birthday column=================
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Date of birth',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900)),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          // BIRTH DAY DROPDOWN
                                          Column(
                                            children: <Widget>[
                                              DropdownButton(
                                                  underline: SizedBox(),
                                                  dropdownColor: Colors.white70,
                                                  elevation: 20,
                                                  value: birthDayDropValue,
                                                  items: daylist().map<
                                                      DropdownMenuItem<
                                                          int>>((int value) {
                                                    return DropdownMenuItem(
                                                        value: value,
                                                        child: Text(
                                                          '$value',
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ));
                                                  }).toList(),
                                                  onChanged: (int value) {
                                                    setState(() {
                                                      birthDayDropValue = value;
                                                    });
                                                  }),
                                              Text(
                                                'd',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              )
                                            ],
                                          ),

                                          //BIRTH MONTH
                                          Column(
                                            children: <Widget>[
                                              DropdownButton(
                                                  underline: SizedBox(),
                                                  dropdownColor: Colors.white70,
                                                  elevation: 20,
                                                  value: birthMonthDropValue,
                                                  items: monthList().map<
                                                      DropdownMenuItem<
                                                          int>>((value) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: value,
                                                      child: Text(
                                                        '$value',
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (int value) {
                                                    setState(() {
                                                      birthMonthDropValue =
                                                          value;
                                                    });
                                                  }),
                                              Text(
                                                'm',
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              )
                                            ],
                                          ),

                                          // BIRTHYEAR DROPDOWN
                                          Column(
                                            children: <Widget>[
                                              DropdownButton(
                                                  underline: SizedBox(),
                                                  dropdownColor: Colors.white70,
                                                  elevation: 20,
                                                  value: birthYearDopValue,
                                                  items: yearlist().map<
                                                      DropdownMenuItem<
                                                          int>>((int value) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: value,
                                                      child: Text(
                                                        '$value',
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (int value) {
                                                    setState(() {
                                                      birthYearDopValue = value;
                                                    });
                                                  }),
                                              Text(
                                                'y',
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: minimumPadding),
                  child: MaterialButton(
                    // textColor: Colors.black,

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),

                    onPressed: () async {
                      _validator();
                    },

                    color: Colors.pink,
                    child: Text(
                      'Signup',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          letterSpacing: 2.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Allready have an account ?',
                        textAlign: TextAlign.center,
                      )
                      // RichText(
                      //   text: TextSpan(
                      //     text: 'Allready have an account?',
                      //     style: TextStyle(
                      //         fontStyle: FontStyle.italic,
                      //         // color: Colors.deepOrange
                      //         ),
                      //   ),
                      //   textAlign: TextAlign.center,
                      // )
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Or',
                    style: TextStyle(fontSize: 15),
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
                ),
              ],
            ),
            Visibility(
                visible: loading ?? true,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.7)),
                  child: Center(
                    child: Container(height: 20,width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.red),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  emailContModel() => model.email = emailController.text;

  passwordContModel() => model.passWord = passwordController.text;

  firstNameContModel() => model.firstName = firstNameController.text;

  surNameContModel() => model.surName = surNameController.text;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
      print('database INITIALIZED successfully');
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  //VALIDATE AND SUBMINT
  _validator() async {
    FormState _formState = _formKeySignUp.currentState;

    assert(model.gender != null, Fluttertoast.showToast(msg: 'sellect gender'));

    assert(birthYearDopValue != now.year,
        Fluttertoast.showToast(msg: 'invalid date'));
    dateToString();
    setState(() {
      validDate = true;
    });

    if (_formState.validate()) {
      if (validDate == true) {
        AuthWithEmailPassword authWithEmailPassword = AuthWithEmailPassword(
            email: model.email,
            password: model.passWord,
            userMap: model.toMap());

        if (_initialized == true) {
          await authWithEmailPassword.signUpAuthentic();

          if (widget.errorMessage == null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
            _formState.reset();
            validDate = null;
          } else {
            Fluttertoast.showToast(msg: widget.errorMessage);
          }
        }
      }
    } else if (_error) {
      Fluttertoast.showToast(msg: 'Somethin went wrong');
    }
  }

//Gender index to String converter for database saving
  genderStringValue(GenderCharacter gendaStrngs) {
    if (gendaStrngs == GenderCharacter.male) {
      model.gender = 'male';
    } else if (gendaStrngs == GenderCharacter.female) {
      model.gender = 'female';
    } else if (gendaStrngs == GenderCharacter.others) {
      model.gender = 'others';
    }
  }

  //YEAR DROPDOWN;
  List<int> yearlist() {
    List<int> yearOfBirth = List<int>();

    for (int i = 2020; i != 1959; i--) {
      yearOfBirth.add(i);
    }
    // List<String> stringbonyear = yearOfBirth.map(String.parse​).toList();
    return yearOfBirth;
  }

  // DAY DROPDOWN
  List<int> daylist() {
    List dayOfBirth = List<int>();
    for (int i = 1; i <= 31; i++) {
      dayOfBirth.add(i);
    }
    return dayOfBirth;
  }

// MONTH DROOPDOWN
  List<int> monthList() {
    List montyOfBirth = List<int>();
    for (int i = 1; i <= 12; i++) {
      montyOfBirth.add(i);
    }
    return montyOfBirth;
  }

//convert the date integer values to string value
  dateToString() {
    String day = birthDayDropValue.toString();
    String month = birthMonthDropValue.toString();
    String year = birthYearDopValue.toString();
    model.dateOfBirth = '$day/$month/$year ';
    print(model.dateOfBirth);
  }
}
