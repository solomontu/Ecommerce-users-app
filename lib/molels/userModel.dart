class UserModel {
  String _email;
  String _passWord;
  String _firstName;
  String _surName;
  String _dateOfBirth;
  String _gender;
  // List<Map<String, dynamic>> _dateOfBirth;


  String get email => _email;
  String get passWord => _passWord;
  String get firstName => _firstName;
  String get surName => _surName;
  String get dateOfBirth => _dateOfBirth;
  String get gender => _gender;

  // List get date => _dateOfBirth;

  set email(String newEmail) => this._email = newEmail;
  set passWord(String newPassword) => this._passWord = newPassword;
  set firstName(String newFirstName) => this._firstName = newFirstName;
  set surName(String newSurNam) => this._surName = newSurNam;
  set dateOfBirth(String newdateOfBirth) => this._dateOfBirth = newdateOfBirth;
  set gender(String newGendr) => this._gender = newGendr;
  // set dateOf(List newDate) => this._dateOfBirth = newDate;

  //CONVER THE MODEL OBJECT INTO A MAP OBJECT
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['FirstName'] = _firstName;
    map['Surname'] = _surName;
    map['Email'] = _email;
    map['Password'] = _passWord;
    map['Gender'] = _gender;
    map['Date of birth'] = _dateOfBirth;
    return map;
  }
}
//
