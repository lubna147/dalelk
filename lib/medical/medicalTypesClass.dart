class medicalTypesClass {
  medicalTypesClass(this._id, this._title);
  int _id = 0;

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String _title = '';

  String get title => _title;

  set title(String title) {
    _title = title;
  }
}
