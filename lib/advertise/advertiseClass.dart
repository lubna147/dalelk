import 'package:flutter/material.dart';

class advertiseClass {
  int _id = 0;

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String _owner = '';

  String get owner => _owner;

  set owner(String owner) {
    _owner = owner;
  }

  String _title = '';

  String get title => _title;

  set title(String title) {
    _title = title;
  }

  String _location = '';

  String get location => _location;

  set location(String location) {
    _location = location;
  }

  String _phonenum = '';

  String get phonenum => _phonenum;

  set phonenum(String phonenum) {
    _phonenum = phonenum;
  }

  String _price = '';

  String get price => _price;

  set price(String price) {
    _price = price;
  }

  String _imageUrl = '';

  String get imageUrl => _imageUrl;

  set imageUrl(String imageUrl) {
    _imageUrl = imageUrl;
  }

  String _detailes = '';

  String get detailes => _detailes;

  set detailes(String detailes) {
    _detailes = detailes;
  }

  String _monyType;

  String get monyType => _monyType;

  set monyType(String monyType) {
    _monyType = monyType;
  }

  advertiseClass(
      this._id,
      this._owner,
      this._title,
      this._location,
      this._phonenum,
      this._price,
      this._imageUrl,
      this._detailes,
      this._monyType);
}
