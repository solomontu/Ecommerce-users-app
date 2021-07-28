import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/controle/authServices.dart';
import 'package:flutter_ecom/models/userModel.dart';
import 'package:flutter_ecom/view/Screens/myHomePage.dart';
import 'package:flutter_ecom/view/common/flutterToast.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum GenderCharacter { male, female, others, initial }

final passWordVisbility = StateProvider<bool>((ref) {
  return true;
});
final gender = StateProvider<GenderCharacter>((ref) {
  return GenderCharacter.initial;
});
final birthDayDropValue = StateProvider<int>((ref) {
  int value;
  return value;
});
final birthMonthDropValue = StateProvider<int>((ref) {
  int value;
  return value;
});
final birthYearDropValue = StateProvider<int>((ref) {
  int value;
  return value;
});

// ignore: must_be_immutable
class SignUp extends ConsumerWidget {
  UserModel model = UserModel();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final surNameController = TextEditingController();
  final _formKeySignUp = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // final model = model();

  String genderString;
  bool validDate = false;
  bool loading = false;
  bool isLogedIn = false;
  // bool hidepassword = true; /*for hiding the passeord with red_eye_icon*/

  final minimumPadding = 10.0;

  var now = new DateTime.now();
  // var berlinWallFell = new DateTime.utc(1989, 11, 9);

  int dayString;
  int yearString;
  int monthString;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Status status = watch(authStatus);
    AuthWithEmailPassword others = watch(authStatus.notifier);
    final hidepassword = watch(passWordVisbility);
    final _character = watch(gender);
    final day = watch(birthDayDropValue);
    final month = watch(birthMonthDropValue);
    final year = watch(birthYearDropValue);
    return Scaffold(
      key: _scaffoldKey,
      body: Card(
        child: Center(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: Form(
                  key: _formKeySignUp,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, bottom: 15),
                          child: Text(
                            'Signup',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                letterSpacing: 4),
                          ),
                        ),
                        // First name
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: firstNameController,
                            decoration: InputDecoration(
                              // border: InputBorder.none,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // borderSide:
                                //     BorderSide(color: Colors.pinkAccent)
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                // color: Colors.black,
                              ),
                              // alignLabelWithHint: true,
                              hintText: 'First name',
                            ),
                            validator: (input) {
                              if (input.isEmpty) {
                                return "input name";
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4),
                          child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: surNameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // borderSide:
                                  //     BorderSide(color: Colors.pinkAccent)
                                ),
                                // border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  // color: Colors.black
                                ),
                                // alignLabelWithHint: true,
                                hintText: 'Surname',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Input surname';
                                }

                                return null;
                              },
                              onChanged: (value) {
                                surNameContModel();
                              }),
                        ),

                        //EMAIL FIELD SETTINGS
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // borderSide:
                                //     BorderSide(color: Colors.pinkAccent)
                              ),
                              // border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.alternate_email,
                                //  color: Colors.black
                              ),
                              // alignLabelWithHint: true,
                              hintText: 'Email',
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4),
                          child: TextFormField(
                            obscureText: hidepassword.state,
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // borderSide:
                                //     BorderSide(color: Colors.pinkAccent)
                              ),
                              // border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                // color: Colors.black
                              ),
                              suffixIcon: GestureDetector(
                                  child: Icon(Icons.remove_red_eye,
                                      color: hidepassword.state
                                          ? Colors.grey
                                          : Theme.of(context).primaryColor),
                                  onTap: () => hidepassword.state
                                      ? hidepassword.state = false
                                      : hidepassword.state = true),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Gender',
                                style: TextStyle(
                                  letterSpacing: 1.5,
                                  // color: Colors.black,
                                  // fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //================ RADIO BUTTON ============= =======================
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: minimumPadding, vertical: 8),
                          child: Container(
                            // color: Colors.grey[300],
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
                                      Material(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Colors.white.withOpacity(0.5),
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
                                                      value:
                                                          GenderCharacter.male,
                                                      groupValue:
                                                          _character.state,
                                                      onChanged: (value) {
                                                        _character.state =
                                                            value;
                                                        genderStringValue(
                                                            _character.state);
                                                      }),
                                                  Text('Male',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54))
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
                                                      value: GenderCharacter
                                                          .female,
                                                      groupValue:
                                                          _character.state,
                                                      onChanged: (value) {
                                                        _character.state =
                                                            value;

                                                        genderStringValue(
                                                            _character.state);
                                                      }),
                                                  Text('Female',
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
                                                      value: GenderCharacter
                                                          .others,
                                                      groupValue:
                                                          _character.state,
                                                      onChanged: (value) {
                                                        _character.state =
                                                            value;
                                                        genderStringValue(
                                                            _character.state);
                                                      }),
                                                  Text('Others',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ================Birthday column=================
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Date of birth',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      // color: Colors.black,
                                      // fontWeight: FontWeight.w900,
                                      letterSpacing: 1.5)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
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
                                    DropdownButton(
                                        hint: Text(
                                          'Day',
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        underline: SizedBox(),
                                        dropdownColor:
                                            Theme.of(context).primaryColor,
                                        elevation: 20,
                                        value: day.state,
                                        items: daylist()
                                            .map<DropdownMenuItem<int>>(
                                                (int value) {
                                          return DropdownMenuItem(
                                              value: value,
                                              child: Text(
                                                '$value',
                                                style: TextStyle(
                                                    color: Colors.black87),
                                              ));
                                        }).toList(),
                                        onChanged: (int value) {
                                          day.state = value;
                                          dayString = value;
                                        }),

                                    //BIRTH MONTH
                                    DropdownButton(
                                        hint: Text(
                                          'Month',
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        underline: SizedBox(),
                                        dropdownColor:
                                            Theme.of(context).primaryColor,
                                        elevation: 20,
                                        value: month.state,
                                        items: monthList()
                                            .map<DropdownMenuItem<int>>(
                                                (value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Text(
                                              '$value',
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (int value) {
                                          month.state = value;
                                          monthString = value;
                                        }),

                                    // BIRTHYEAR DROPDOWN
                                    Column(
                                      children: <Widget>[
                                        DropdownButton(
                                            hint: Text(
                                              'Year',
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ),
                                            underline: SizedBox(),
                                            dropdownColor:
                                                Theme.of(context).primaryColor,
                                            elevation: 20,
                                            value: year.state,
                                            items: yearlist()
                                                .map<DropdownMenuItem<int>>(
                                                    (int value) {
                                              return DropdownMenuItem<int>(
                                                value: value,
                                                child: Text(
                                                  '$value',
                                                  style: TextStyle(
                                                      color: Colors.black87),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (int value) {
                                              year.state = value;
                                              yearString = value;
                                            }),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: minimumPadding),
                          child: MaterialButton(
                            // textColor: Colors.black,

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),

                            onPressed: () async {
                              _validator();
                              FormState _formState =
                                  _formKeySignUp.currentState;
                              if (_formState.validate() &&
                                  _validator() == true) {
                                // assert(await others.chekNetwork() == true,
                                // toast(msg: 'No network'));
                                Future<bool> signUp =
                                    others.signUp(userMap: model.toMap());

                                if (!await signUp) {
                                  toast(
                                    msg: others.message.toString(),
                                  );

                                  // _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  //   content: Text(others.error.toString()),
                                  // ));
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => MyHomePage()));
                                }
                              }
                            },

                            color: Theme.of(context).primaryColorDark,
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 2.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Already have an account ?',
                                style: TextStyle(letterSpacing: 1.5),
                                textAlign: TextAlign.center,
                              )),
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
                                padding:
                                    EdgeInsets.only(bottom: minimumPadding),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    // Do stuff here;
                                  },
                                  child: ClipOval(
                                    child: SvgPicture.asset(
                                      'Assets/images/singleImages/facebook-logo@logotyp.us.svg',
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                )),
                            Padding(
                                padding:
                                    EdgeInsets.only(bottom: minimumPadding),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    // Do stuff here;
                                  },
                                  child: ClipOval(
                                      child: Image(
                                    image: AssetImage(
                                        'Assets/images/singleImages/ggg.png'),
                                    height: 40,
                                    width: 40,
                                  )

                                      // ),
                                      ),
                                )),
                          ],
                        ),
                      ],
                    ),
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

  emailContModel() => model.email = emailController.text;

  passwordContModel() => model.passWord = passwordController.text;

  firstNameContModel() => model.firstName = firstNameController.text;

  surNameContModel() => model.surName = surNameController.text;

  //VALIDATE AND SUBMINT
  bool _validator() {
    dateToString();
    assert(model.gender != null, toast(msg: 'sellect gender'));

    assert(
        dayString != null,
        toast(
          msg: 'sellect day',
        ));
    assert(
        monthString != null,
        toast(
          msg: 'sellect month',
        ));
    assert(
        yearString != null,
        toast(
          msg: 'sellect year',
        ));
    // assert(day != now.year,
    //     Fluttertoast.showToast(msg: 'invalid date'));

    return true;
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
    List<int> yearOfBirth = <int>[];

    for (int i = now.year; i != 1959; i--) {
      yearOfBirth.add(i);
    }
    // List<String> stringbonyear = yearOfBirth.map(String.parse​).toList();
    return yearOfBirth;
  }

  // DAY DROPDOWN
  List<int> daylist() {
    List dayOfBirth = <int>[];
    for (int i = 1; i <= 31; i++) {
      dayOfBirth.add(i);
    }
    return dayOfBirth;
  }

// MONTH DROOPDOWN
  List<int> monthList() {
    List montyOfBirth = <int>[];
    for (int i = 1; i <= 12; i++) {
      montyOfBirth.add(i);
    }
    return montyOfBirth;
  }

// //convert the date integer values to string value
  dateToString() {
    String day = dayString.toString();
    String month = monthString.toString();
    String year = yearString.toString();
    model.dateOfBirth = '$day/$month/$year ';
    print('THE DAY MONT AND YEAR IS: $day/$month/$year');
  }
}
