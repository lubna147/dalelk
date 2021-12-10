import 'dart:io';

import 'package:dalelk/advertise/advertiseClass.dart';
import 'package:dalelk/extraTools/internetConnectionTest.dart';
import 'package:dalelk/extraTools/mySharedPreferences.dart';
import 'package:dalelk/extraTools/serverConnection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

class newAdvertise extends StatefulWidget {
  advertiseClass tempAd;
  newAdvertise(this.tempAd);
  @override
  _newAdvertiseState createState() => _newAdvertiseState();
}

bool _isPressed = false;
final ImagePicker _picker = ImagePicker();
File _image = File('file.txt');
bool imageBox = false;
TextStyle choose = new TextStyle(fontSize: 12);
//bool _value = false;
int val = 0;
String monyType = "ليرة تركية";
Map<String, String> body = new Map<String, String>();
TextEditingController title = new TextEditingController();
TextEditingController price = new TextEditingController();
TextEditingController detailes = new TextEditingController();
// TextEditingController  = new TextEditingController();
String owner = '';
String location = '';
String phone = '';
int id = 0;
int advid = 0;
bool add = false;
var t = ['hu', 'jhgjgyf', 'ctyfytfjy'];
final _formKey = new GlobalKey<FormState>();
String imageUrl = '';
bool editAd = false;
server serverC = new server();
String appBarTitle = 'إضافة إعلان';
List<String> types = <String>[
  'ألبسة نسائية',
  'أحذية و حقائب',
  'ألبسة أطفال',
  'ألبسة رجالية',
  'أحذية رجالية',
  'صرافة و حوالات',
  'مفروشات',
  'تجارة سيارات',
  'مكياج و اكسسوارات',
  'مطاعم و كافيهات',
  'أقمشة و مستلزماتها',
  'عقارات و تعهدات',
  'معاهد و مؤسسات تعليمية',
  'تصميم داخلي',
  'مأكولات',
  'ألعاب و هدايا',
  'مجوهرات',
  'أجهزة الكترونية',
  'أجهرة كهربائية',
  'مكتبات',
  'نقل و سفريات',
  'أدوات منزلية',
  'سيارات مياه',
  'طباعة و إعلان',
  'حلويات و طبخ عربي',
  'خردوات',
  'برمجة وتصميم',
  'خدمات توصيل',
  'تجارة جملة',
  'سوبر ماركت',
  'متفرقات',
];
internetConnectionTest test = new internetConnectionTest();

class _newAdvertiseState extends State<newAdvertise> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.tempAd.title != '') {
      setState(() {
        appBarTitle = 'تعديل إعلان';
      });
      title.text = widget.tempAd.title;
      String s = widget.tempAd.price;
      price.text = s.substring(s.lastIndexOf(" ") + 1);
      detailes.text = widget.tempAd.detailes;
      imageUrl = widget.tempAd.imageUrl;
      editAd = true;
      imageBox = false;
      advid = widget.tempAd.id;
      print(
          'eeeeeeeeeeeeddddddddddddddddddddiiiiiiiiiiiiiiitttttttttttteeeeee');
      print(editAd);
      //  _chosenValue = '';
    }
    MySharedPreferences.instance.getStringValue("palceName").then((value) {
      setState(() {
        owner = value;
        print(owner);
      });
    });
    MySharedPreferences.instance.getStringValue("place").then((value) {
      setState(() {
        location = value;
        print(location);
        print('acssssssssssssssssssssssssssssss');
      });
    });
    MySharedPreferences.instance.getStringValue("phone").then((value) {
      setState(() {
        phone = value;
      });
    });
    MySharedPreferences.instance.getIntegerValue("userId").then((value) {
      setState(() {
        id = value;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clearData();
  }

  String _chosenValue = 'ألبسة نسائية';
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('مادة الإعلان  '),
                TextFormField(
                  controller: title,
                  validator: (value) =>
                      (value == '') ? 'الرجاء ملئ الحقل' : null,
                  //       onSaved: (value) => _email = value,

                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        child: TextFormField(
                          controller: price,
                          validator: (value) =>
                              (value == '') ? 'الرجاء ملئ الحقل' : null,
                          //       onSaved: (value) => _email = value,

                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            hintTextDirection: TextDirection.rtl,
                            contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(' : السعر'),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(': العملة'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      title: Text(
                        "ليرة تركية",
                        style: choose,
                      ),
                      horizontalTitleGap: 0,
                      minVerticalPadding: 0,
                      leading: Radio(
                        value: 0,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            val = int.parse(value.toString());
                            monyType = "ليرة تركية";
                            print(val);
                          });
                        },
                        activeColor: Colors.blueAccent,
                        autofocus: true,
                      ),
                    ),
                    ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      title: Text('دولار', style: choose),
                      leading: Radio(
                        value: 1,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            monyType = 'دولار';
                            val = int.parse(value.toString());
                            print(val);
                          });
                        },
                        activeColor: Colors.blueAccent,
                      ),
                      horizontalTitleGap: 0,
                      minVerticalPadding: 0,
                    ),
                    ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      horizontalTitleGap: 0,
                      minVerticalPadding: 0,
                      title: Text("ليرة سورية", style: choose),
                      leading: Radio(
                        value: 2,
                        groupValue: val,
                        onChanged: (value) {
                          setState(() {
                            monyType = "ليرة سورية";
                            val = int.parse(value.toString());
                            print(val);
                          });
                        },
                        activeColor: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                Text('تفاصيل الإعلان  :'),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: detailes,
                  validator: (value) =>
                      (value == '') ? 'الرجاء ملئ الحقل' : null,
                  //       onSaved: (value) => _email = value,
                  // minLines: 2,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        selectedItemBuilder: (BuildContext context) {
                          return types.map<Widget>((String item) {
                            return Container(
                                width: 200,
                                child:
                                    Text(item, style: TextStyle(fontSize: 12)));
                          }).toList();
                        },
                        validator: (String? value) {
                          (value?.isEmpty ?? true) ? 'الرجاء اختيار صنف' : null;
                        },
                        hint: Text('التصنيفات'),
                        value: _chosenValue,
                        //   itemHeight: 20,
                        items: types.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Text(
                                  value,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _chosenValue = value.toString();
                          });
                        },
                      ),
                    )
                  ],
                ),
                /*  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButtonFormField<String>(
                      /*  validator: (String? value) {
                        (value?.isEmpty ?? true) ? 'الرجاء اختيار صنف' : null;
                      },*/
                      hint: Text('التصنيفات'),
                      value: _chosenValue,
                      //   itemHeight: 20,
                      items: types.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _chosenValue = value.toString();
                        });
                      },
                    )
                    /*    DropDown(
                      
                      showUnderline: true,
                      //  isExpanded: true,
                      items: types,
                      hint: Text("الـتصنيفـات", style: choose),
                      onChanged: (value) {
                        _chosenValue = value;
                      },
                    ),*/
                  ],
                ),
               */
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _imgFromCamera();
                          },
                          child:
                              Icon(Icons.add_a_photo, color: Color(0xffc5cec3)),
                          style: OutlinedButton.styleFrom(
                              primary: Color(0xffc5cec3)),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              _imgFromGallery();
                            },
                            child: Icon(
                              Icons.add_photo_alternate,
                              color: Color(0xffc5cec3),
                            ),
                            style: OutlinedButton.styleFrom(
                                primary: Color(0xffc5cec3))),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: imageBox,
                  child: Container(
                    child: Stack(alignment: Alignment.topLeft, children: [
                      _image == null
                          ? Text('data')
                          : Image.file(
                              _image,
                              fit: BoxFit.contain,
                            ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              //   _image = new File(path);
                              imageBox = false;
                            });
                          },
                          icon: Icon(
                            Icons.close_sharp,
                            color: Colors.black87,
                            size: 30,
                          ),
                          // splashColor: Colors.amber,
                        ),
                      )
                    ]),
                  ),
                ),
                Visibility(
                    visible: editAd,
                    child: Image.network(
                      'https://dalelalbab.xyz/${widget.tempAd.imageUrl}',
                      fit: BoxFit.contain,
                    )),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('إلغاء'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xffc5cec3)),
                            //       shape: MaterialStateProperty.all(OutlinedBorder(side: )))) ,
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(8)),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(fontSize: 12, color: Colors.white))),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isPressed == false ? sendData : null,
                        child: Text('موافق'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xffc5cec3)),
                            //       shape: MaterialStateProperty.all(OutlinedBorder(side: )))) ,
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(8)),
                            textStyle: MaterialStateProperty.all(
                                TextStyle(fontSize: 12, color: Colors.white))),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendData() {
    setState(() {
      _isPressed = true;
    });
    print(monyType + price.text);
    final FormState? form = _formKey.currentState;
    print(_image.path);
    if (form!.validate()) {
      if (widget.tempAd.imageUrl != '' || _image.path != 'file.txt') {
        body = {
          "user_id": id.toString(),
          "class_id": types.indexOf(_chosenValue).toString(),
          "name": owner,
          "title": title.text,
          "palce": location,
          "contact_num": phone,
          "price": price.text,
          "monyType": monyType,
          "description": detailes.text
        };
        test.check().then((intenet) {
          if (intenet != null && intenet) {
            if (widget.tempAd.title != '')
              serverC.updateAdvertise(body, _image.path, advid).then((value) {
                if (value) {
                  done();
                  clearData();
                  setState(() {
                    _isPressed = false;
                  });
                } else
                  retry();
              });
            else
              serverC.addNewAdvertise(body, _image.path).then((value) {
                if (value) {
                  done();
                  clearData();
                  setState(() {
                    _isPressed = false;
                  });
                } else
                  retry();
              });
          } else {
            noInternrt();
          }
        });
        print('Form is valid');
      } else {
        Fluttertoast.showToast(
            msg: "!الرجاء تحميل صورة",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 13);
      }
    } else {
      print('Form is invalid');
    }
  }

  /////////////////////////////
  _imgFromCamera() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
    );

    setState(() {
      _image = File(image!.path);
      print(_image);
      if (_image != null) {
        imageBox = true;
        editAd = false;
      }
    });
  }

  _imgFromGallery() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _image = File(image!.path);
      if (_image != null) {
        imageBox = true;
        editAd = false;
      }
    });
  }

  noInternrt() {
    Fluttertoast.showToast(
        msg: "!تحقق من اتصالك بالانترنت",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 13);
  }

  done() {
    Fluttertoast.showToast(
        msg: "تم حفظ المنشور بنجاح",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 13);
  }

  retry() {
    setState(() {
      _isPressed = false;
    });
    Fluttertoast.showToast(
        msg: "حدث خطأ أثناء التحميل الرجاء المحاولة لاحقاً",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 13);
  }

  clearData() {
    title.clear();
    price.clear();
    detailes.clear();
    imageUrl = '';

    _image = File('file.txt');
    setState(() {
      imageBox = false;
      editAd = false;
    });
  }
}
