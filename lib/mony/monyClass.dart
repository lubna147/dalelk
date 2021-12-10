class monyClas {
  monyClas(this._sale, this._buy, this._state, this._time);
  String _buy;

  String get buy => _buy;

  set buy(String buy) {
    _buy = buy;
  }

  String _sale;

  String get sale => _sale;

  set sale(String sale) {
    _sale = sale;
  }

  int _state;

  int get state => _state;

  set state(int state) {
    _state = state;
  }

  String _time;

  String get time => _time;

  set time(String time) {
    _time = time;
  }
}
