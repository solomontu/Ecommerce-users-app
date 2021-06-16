import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const FIRST_NAME = 'FirstName';
  static const SURNAME = 'Surname';
  static const EMAIL = 'Email';
  static const PASSWORD = 'Password';
  static const GENDER = 'Gender';
  static const DATE_OF_BIRTH = 'Date of birth';
  static const PHOTOURL = 'PhotoUrl';
  static const UID = 'Uid';

  String _uid;
  String _email;
  String _passWord;
  String _firstName;
  String _surName;
  String _dateOfBirth;
  String _gender;
  String _photoUrl;

  UserModel(
      [this._uid,
      this._email,
      this._passWord,
      this._firstName,
      this._dateOfBirth,
      this._gender,
      this._surName,
      this._photoUrl]);


  String get email => _email;
  String get passWord => _passWord;
  String get firstName => _firstName;
  String get surName => _surName;
  String get dateOfBirth => _dateOfBirth;
  String get gender => _gender;
  String get uid => _uid;
  String get photoUrl => _photoUrl;

  set email(String newEmail) => this._email = newEmail;

  set passWord(String newPassword) => this._passWord = newPassword;

  set firstName(String newFirstName) => this._firstName = newFirstName;

  set surName(String newSurNam) => this._surName = newSurNam;

  set dateOfBirth(String newdateOfBirth) => this._dateOfBirth = newdateOfBirth;

  set gender(String newGendr) => this._gender = newGendr;

  set phoUrl(String newPhotoUrl) => this._photoUrl = newPhotoUrl;

  // set dateOf(List newDate) => this._dateOfBirth = newDate;

  //CONVER THE MODEL OBJECT INTO A MAP OBJECT
  Map<String, dynamic> toMap() {
    Map map = Map<String, dynamic>();
    map[FIRST_NAME] = _firstName;
    map[SURNAME] = _surName;
    map[EMAIL] = _email;
    map[PASSWORD] = _passWord;
    map[GENDER] = _gender;
    map[DATE_OF_BIRTH] = _dateOfBirth;
    map[PHOTOURL] = _photoUrl;
    return map;
  }

  //from shapshot values to map
  UserModel.fromSnapShot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _email = data[EMAIL] ?? '';
    _passWord = data[PASSWORD] ?? '';
    _firstName = data[FIRST_NAME] ?? '';
    _surName = data[SURNAME] ?? '';
    _dateOfBirth = data[DATE_OF_BIRTH] ?? '';
    _gender = data[GENDER] ?? '';
    _photoUrl = data[PHOTOURL] ??
        'https://firebasestorage.googleapis.com/v0/b/ecommerce-cbc61.appspot.com/o/cusom_images%2Fprofile%20image.png?alt=media&token=5be100b2-ac9c-4413-9c39-d1f947cddac1';
  }

  //from shapshot values to map
  UserModel.fromSnapSteam(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _email = data[EMAIL] ?? '';
    _passWord = data[PASSWORD] ?? '';
    _firstName = data[FIRST_NAME] ?? '';
    _surName = data[SURNAME] ?? '';
    _dateOfBirth = data[DATE_OF_BIRTH] ?? '';
    _gender = data[GENDER] ?? '';
    _photoUrl = data[PHOTOURL] ?? '';
  }
}
//
