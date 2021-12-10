import 'dart:ui';

import 'package:dalelk/UserFiles/userInformations.dart';
import 'package:dalelk/extraTools/mySharedPreferences.dart';
import 'package:dalelk/extraTools/navigationPages.dart';
import 'package:dalelk/extraTools/serverConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'internetConnectionTest.dart';

class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  server serverC = new server();

  internetConnectionTest test = new internetConnectionTest();

  final _formKey = new GlobalKey<FormState>();

  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   extendBody: true,
      //     backgroundColor: Color(0xffc5cec3),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white70,
              border: Border.all(
                color: Color(0xffc5cec3),
                width: 1,
              )),
          padding: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * 0.9,
          //     color: Colors.white54,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('تسجيل الدخول'),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: username,
                  validator: (value) =>
                      (value == '') ? 'الرجاء ملئ الحقل' : null,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            BorderSide(color: Color(0xffc5cec3), width: 1),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintTextDirection: TextDirection.rtl,
                      labelText: 'اسم المستخدم',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      suffixIcon: Icon(
                        EvilIcons.user,
                        color: Color(0xffc5cec3),
                        size: 30,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffc5cec3)),
                          borderRadius: BorderRadius.circular(30))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: password,
                  validator: (value) =>
                      (value == '') ? 'الرجاء ملئ الحقل' : null,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'كلمة المرور',
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      suffixIcon: Icon(
                        MaterialCommunityIcons.lock,
                        color: Color(0xffc5cec3),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            BorderSide(color: Color(0xffc5cec3), width: 1),
                      ),
                      border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Color(0xffc5cec3)),
                          gapPadding: 8,
                          borderRadius: BorderRadius.circular(30))),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(BorderSide(
                              color: Color(0xffc5cec3),
                              width: 0.5,
                            )),
                            foregroundColor: MaterialStateProperty.all(
                              Color(0xffc5cec3),
                            )),
                        onPressed: () {
                          int id;
                          final FormState? form = _formKey.currentState;
                          if (form!.validate()) {
                            print('Form is valid');
                            test.check().then((intenet) {
                              if (intenet != null && intenet)
                                serverC
                                    .getUserId(username.text, password.text)
                                    .then((value) {
                                  /*  if (value.id != 0) {
                                    id = value.id;
                                    MySharedPreferences.instance
                                        .getIntegerValue("userId")
                                        .then((value) {
                                      MySharedPreferences.instance
                                          .setStringValue(
                                              "userName", username.text);
                                      MySharedPreferences.instance
                                          .setStringValue(
                                              "passWord", password.text);
                                      if (value != id) {
                                        setState(() {
                                          MySharedPreferences.instance
                                              .setBooleanValue("logIn", true);
                                          MySharedPreferences.instance
                                              .setIntegerValue("userId", id);
                                       /*   MySharedPreferences.instance
                                              .setBooleanValue(
                                                  "firstTime", true);*/
                                        });
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    userInformation()));
                                        // Navigator.pop(context);
                                      } else {
                                        MySharedPreferences.instance
                                            .setBooleanValue("logIn", true);
                                        Navigator.pop(context);
                                        Navigator.pushAndRemoveUntil<dynamic>(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  navigationPages()),
                                          (route) => false,
                                        );
                                      }
                                    });
                                  }*/
                                  if (value.id != 0) {
                                    MySharedPreferences.instance.setStringValue(
                                        "userName", username.text);
                                    MySharedPreferences.instance.setStringValue(
                                        "passWord", password.text);
                                    MySharedPreferences.instance
                                        .setIntegerValue("userId", value.id);
                                    MySharedPreferences.instance.setStringValue(
                                        "palceName", value.shopName);
                                    MySharedPreferences.instance.setStringValue(
                                        "place", value.shopLocation);
                                    MySharedPreferences.instance.setStringValue(
                                        "phone", value.shopPhone);
                                    MySharedPreferences.instance
                                        .setBooleanValue("firstTime", false);
                                    MySharedPreferences.instance
                                        .setBooleanValue("logIn", true);
                                    Navigator.pop(context);
                                    Navigator.pushAndRemoveUntil<dynamic>(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              navigationPages()),
                                      (route) => false,
                                    );
                                  } else {
                                    wrongInfo();
                                  }
                                });
                              else {
                                noInternrt();
                              }
                            });
                          }
                        },
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(color: Color(0xffc5cec3)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xffc5cec3),
                            ),
                            foregroundColor: MaterialStateProperty.all(
                              Colors.white,
                            )),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => navigationPages()));
                        },
                        child: Text(
                          'متابعة للصفحة الرئيسية',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        FlutterOpenWhatsapp.sendSingleMessage(905348154568, "");
                      },
                      child: Text('اتصل بنا',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blueAccent)),
                    ),
                    Text('ليس لديك حساب؟  ',
                        style: TextStyle(
                          fontSize: 13,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
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

  wrongInfo() {
    Fluttertoast.showToast(
        msg: "!خطأ في اسم المستخدم أو كلمة المرور",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 13);
  }
}
