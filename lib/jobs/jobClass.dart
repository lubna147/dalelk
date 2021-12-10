class jobClass {
  jobClass(this._id, this._boss, this._job, this._location, this._phoneNumber,
      this._detailes);
  int _id = 0;

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String _boss = '';

  String get boss => _boss;

  set boss(String boss) {
    _boss = boss;
  }

  String _job = '';

  String get job => _job;

  set job(String job) {
    _job = job;
  }

  String _location = '';

  String get location => _location;

  set location(String location) {
    _location = location;
  }

  String _phoneNumber = '';

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
  }

  String _detailes = '';

  String get detailes => _detailes;

  set detailes(String detailes) {
    _detailes = detailes;
  }
}
