import 'package:dalelk/extraTools/internetConnectionTest.dart';
import 'package:dalelk/extraTools/loadingPage.dart';
import 'package:dalelk/extraTools/noIternetConnection.dart';
import 'package:dalelk/extraTools/nothingToShow.dart';
import 'package:dalelk/extraTools/serverConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class contactNumberPage extends StatefulWidget {
  const contactNumberPage({Key? key}) : super(key: key);

  @override
  _contactNumberPageState createState() => _contactNumberPageState();
}

internetConnectionTest test = new internetConnectionTest();
Widget temp = loadingPage();
server serverC = new server();
List<String> nums = [];

class _contactNumberPageState extends State<contactNumberPage> {
  void initState() {
    // TODO: implement initState
    super.initState();
    temp = loadingPage();
    test.check().then((intenet) {
      if (intenet != null && intenet) {
        print('object');
        if (nums.isEmpty) {
          temp = loadingPage();
          serverC.getContactNumMony().then((value) {
            if (value.isEmpty) {
              setState(() {
                temp = nothingToShow();
              });
            } else {
              setState(() {
                nums.clear();
                nums.addAll(value);
                temp = mainPage();
              });
            }
          });
        }
      } else
        setState(() {
          temp = noInternetConnection();
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    test.check().then((intenet) {
      if (intenet != null && intenet) {
        print('object');
        if (nums.isEmpty) {
          temp = loadingPage();
          serverC.getContactNum().then((value) {
            if (value.isEmpty) {
              setState(() {
                temp = nothingToShow();
              });
            } else {
              setState(() {
                nums.clear();
                nums.addAll(value);
                temp = mainPage();
              });
            }
          });
        }
      } else
        setState(() {
          temp = noInternetConnection();
        });
    });
    return temp;
  }

  Scaffold mainPage() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('لجميع استفساراتكم الرجاء التواصل مع الأرقام التالية'),
            SizedBox(
              height: 16,
            ),
            numbers(nums[0]),
            SizedBox(
              height: 16,
            ),
            numbers(nums[1]),
            SizedBox(
              height: 16,
            ),
            numbers(nums[2]),
            SizedBox(
              height: 16,
            ),
            //   numbers(''),
          ],
        ),
      ),
    );
  }

  Row numbers(String num) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
            onTap: () {
              print(['object']);
              FlutterOpenWhatsapp.sendSingleMessage(num.substring(0), "");
            },
            child: Text(num,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ))),
        SizedBox(
          width: 16,
        ),
        Icon(MaterialCommunityIcons.whatsapp)
      ],
    );
  }
}
