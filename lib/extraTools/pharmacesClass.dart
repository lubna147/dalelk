class pharmacesClass {
  pharmacesClass(this._name, this._location);
  String _name;

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  String _location;

  String get location => _location;

  set location(String location) {
    _location = location;
  }
}
