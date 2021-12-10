class userClass {
  userClass(this._id, this._shopName, this._shopPhone, this._shopLocation);
  int _id = 0;

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String _shopName = '';

  String get shopName => _shopName;

  set shopName(String shopName) {
    _shopName = shopName;
  }

  String _shopPhone = '';

  String get shopPhone => _shopPhone;

  set shopPhone(String shopPhone) {
    _shopPhone = shopPhone;
  }

  String _shopLocation = '';

  String get shopLocation => _shopLocation;

  set shopLocation(String shopLocation) {
    _shopLocation = shopLocation;
  }
}
