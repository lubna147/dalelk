import 'package:dalelk/extraTools/mySharedPreferences.dart';
import 'package:dalelk/extraTools/navigationPages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class userInformation extends StatefulWidget {
  const userInformation({Key? key}) : super(key: key);

  @override
  _userInformationState createState() => _userInformationState();
}

class _userInformationState extends State<userInformation> {
  PhoneNumber number = PhoneNumber(isoCode: 'TR');
  TextEditingController name = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController location = new TextEditingController();
  String phone = '';
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('معلومات الحساب'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text('  :اسم المُعلن'),
              TextFormField(
                controller: name,
                validator: (value) => (value == '') ? 'الرجاء ملئ الحقل' : null,
                //       onSaved: (value) => _email = value,

                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    hintText: 'صبايا للاكسسوارات',
                    hintStyle: TextStyle(color: Colors.black38)),
              ),
              SizedBox(
                height: 16,
              ),
              Text(' : رقم التواصل'),
              InternationalPhoneNumberInput(
                textFieldController: phoneNumber,
                onInputChanged: (PhoneNumber number) {
                  print(number.phoneNumber);
                  phone = number.phoneNumber.toString();
                },
                onInputValidated: (bool value) {
                  print(value);
                },
                validator: (value) => (value == '') ? 'الرجاء ملئ الحقل' : null,
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                inputDecoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8)),
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: number,
                //  textFieldController: controller,
                // formatInput: false,

                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputBorder: UnderlineInputBorder(),
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
              SizedBox(
                height: 16,
              ),
              Text('  :الموقع'),
              TextFormField(
                controller: location,
                validator: (value) => (value == '') ? 'الرجاء ملئ الحقل' : null,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    hintText: 'مدينة الباب - جانب مشفى الباب',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    )),
              ),
              SizedBox(
                height: 30,
              ),
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
                          padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 12, color: Colors.white))),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final FormState? form = _formKey.currentState;
                        if (form!.validate()) {
                          print('Form is valid');
                          showAlertDialog(context);
                        } else {
                          print('Form is invalid');
                        }
                      },
                      child: Text('موافق'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xffc5cec3)),
                          //       shape: MaterialStateProperty.all(OutlinedBorder(side: )))) ,
                          padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 12, color: Colors.white))),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("إلغاء"),
      onPressed: () {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      },
    );
    Widget continueButton = TextButton(
      child: Text("متابعة"),
      onPressed: () {
        setState(() {
          MySharedPreferences.instance.setStringValue("palceName", name.text);
          MySharedPreferences.instance.setStringValue("place", location.text);
          MySharedPreferences.instance.setStringValue("phone", phone);
          MySharedPreferences.instance.setBooleanValue("firstTime", false);
        });
        Fluttertoast.showToast(
            msg: "تم حفظ المعلومات بنجاح",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 13);
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute(builder: (context) => navigationPages()),
          (route) => false,
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "تنبيـه",
        textAlign: TextAlign.right,
      ),
      content: Text(
          " المعلومات المدخلة سيتم إرفاقها بكل إعلان وهي معلومات غير قابلة للتعديل ",
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.right),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
