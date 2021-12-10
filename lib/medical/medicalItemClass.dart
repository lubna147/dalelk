class medicalItemClass {
  medicalItemClass(
      this._id, this._name, this._location, this._phoneNum, this._filePath);

  int _id = 0;

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String _name = '';

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  String _location = '';

  String get location => _location;

  set location(String location) {
    _location = location;
  }

  String _phoneNum = '';

  String get phoneNum => _phoneNum;

  set phoneNum(String phoneNum) {
    _phoneNum = phoneNum;
  }

  String _filePath = '';

  String get filePath => _filePath;

  set filePath(String filePath) {
    _filePath = filePath;
  }
}
