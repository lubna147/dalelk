import 'package:dalelk/extraTools/serverConnection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class addNewJob extends StatefulWidget {
  const addNewJob({Key? key}) : super(key: key);

  @override
  _addNewJobState createState() => _addNewJobState();
}

final _formKey = new GlobalKey<FormState>();
server serv = new server();
PhoneNumber number = PhoneNumber(isoCode: 'TR');
TextEditingController owner = new TextEditingController();
TextEditingController title = new TextEditingController();
TextEditingController place = new TextEditingController();
TextEditingController phone = new TextEditingController();
TextEditingController detailes = new TextEditingController();
String ss = '';
String phoneHolder = '';

class _addNewJobState extends State<addNewJob> {
  @override
  void dispose() {
    owner.clear();
    title.clear();
    phone.clear();
    place.clear();
    detailes.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إضافة فرصة عمل جديدة',
          style: TextStyle(fontSize: 12),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('الجهة المعلنة'),
              TextFormField(
                controller: owner,
                maxLines: 2,
                validator: (value) => (value == '') ? 'الرجاء ملئ الحقل' : null,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(':المسمى الوظيفي المطلوب'),
              TextFormField(
                controller: title,
                maxLines: 3,
                minLines: 1,
                validator: (value) => (value == '') ? 'الرجاء ملئ الحقل' : null,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(':رقم التواصل'),
              InternationalPhoneNumberInput(
                textFieldController: phone,
                onInputChanged: (PhoneNumber number) {
                  print(number.phoneNumber);
                  phoneHolder = number.phoneNumber.toString();
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
                    hintText: '5389765842',
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
              Text(':الموقع'),
              TextFormField(
                controller: place,
                maxLines: 2,
                validator: (value) => (value == '') ? 'الرجاء ملئ الحقل' : null,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(':تفاصيل الاعلان'),
              TextFormField(
                controller: detailes,
                maxLines: null,
                validator: (value) => (value == '') ? 'الرجاء ملئ الحقل' : null,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                ),
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
                          setState(() {
                            ss = owner.text;
                          });
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
            ],
          ),
        ),
      ),
    );
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
        print(title.text);
        serv.postjob(<String, String>{
          "advertiser": owner.text,
          "title": title.text,
          "phone": phoneHolder,
          "place": place.text,
          "det": detailes.text
        }).then((value) {
          if (value) {
            Fluttertoast.showToast(
                msg: "تم حفظ المعلومات بنجاح",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 13);
            Navigator.pop(context);
            setState(() {});
          } else {
            Fluttertoast.showToast(
                msg: "لم يتم حفظ المعلومات . الرجاء المحاولة لاحقاً",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 13);
          }
        });

        setState(() {
          owner.clear();
          title.clear();
          phone.clear();
          place.clear();
          detailes.clear();
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "تنبيـه",
        textAlign: TextAlign.right,
      ),
      content: Text(
          "الرجاء التأكد من كافة المعلومات المدخلة لانها غير قابلة للتعديل ",
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
