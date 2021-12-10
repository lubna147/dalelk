import 'package:dalelk/extraTools/internetConnectionTest.dart';
import 'package:dalelk/extraTools/loadingPage.dart';
import 'package:dalelk/extraTools/loginPage.dart';
import 'package:dalelk/extraTools/mySharedPreferences.dart';
import 'package:dalelk/extraTools/noIternetConnection.dart';
import 'package:dalelk/extraTools/nothingToShow.dart';
import 'package:dalelk/extraTools/serverConnection.dart';
import 'package:dalelk/mony/monyClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class monyPage extends StatefulWidget {
  const monyPage({Key? key}) : super(key: key);

  @override
  _monyPageState createState() => _monyPageState();
}

internetConnectionTest test = new internetConnectionTest();
Widget temp = loadingPage();
server serverC = new server();
List<monyClas> mony = [];
late Icon DuSy = Icon(Icons.ac_unit_sharp);
late Icon TrSy = Icon(Icons.ac_unit_sharp);
late Icon DuTr = Icon(Icons.ac_unit_sharp);
String ds = '';
String ts = '';
String dt = '';
List<String> nums = [];
Icon upArrow = Icon(
  Icons.arrow_upward_rounded,
  color: Colors.greenAccent,
);
Icon downArrow = Icon(
  Icons.arrow_downward,
  color: Colors.redAccent,
);
Icon nonArrow = Icon(
  Icons.arrow_back,
  color: Colors.orangeAccent,
);
String link = '';

//a2b29f
class _monyPageState extends State<monyPage> {
  void initState() {
    mony.clear();
    nums.clear();
    link = '';
    // TODO: implement initState
    super.initState();
    // mony.clear();
    temp = loadingPage();
    test.check().then((intenet) {
      if (intenet != null && intenet) {
        serverC.getImage().then((value) {
          setState(() {
            link = value;
          });
        });
        if (mony.isEmpty) {
          serverC.getMony().then((value) {
            setState(() {
              mony.addAll(value);
              DuSy = compaire(mony[0].state);
              TrSy = compaire(mony[1].state);
              DuTr = compaire(mony[2].state);
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
                      temp = mainPage(context);
                    });
                  }
                });
              }
            });
          });
        }
      } else
        setState(() {
          temp = noInternetConnection();
        });
    });
  }

  Icon compaire(int i) {
    if (i == 0)
      return nonArrow;
    else if (i == 1)
      return upArrow;
    else
      return downArrow;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return temp;
  }

  Scaffold mainPage(BuildContext context) {
    print('hjfhihfliahfiugfiagfyewgduy');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: FadeInImage.assetNetwork(
                placeholder: 'images/loader.gif',
                placeholderCacheHeight: 50,
                image: 'https://dalelalbab.xyz/$link',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xffc5cec3),
                  )),
              child: Center(
                child: Text('أسعار صرف العملات في مدينة الباب'),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(mony[0].time),
                SizedBox(
                  width: 8,
                ),
                Text('زمن التحديث')
              ],
            ),
            SizedBox(
              height: 16,
            ),
            buySale(
                context, 'دولار - ليرة سورية', mony[0].sale, mony[0].buy, DuSy),
            SizedBox(
              height: 16,
            ),
            buySale(context, 'ليرة تركية - ليرة سورية', mony[1].sale,
                mony[1].buy, TrSy),
            SizedBox(
              height: 16,
            ),
            buySale(
                context, 'دولار - ليرة تركية', mony[2].sale, mony[2].buy, DuTr),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              height: 50,
              decoration: BoxDecoration(
                  //    color: Color(0xffD9A108),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xffc5cec3),
                  )),
              child: Center(
                child: Text('أرقـام التواصـل'),
              ),
            ),
            contactNumber('للاستعلام', nums[0]),
            contactNumber('ارسال حوالة', nums[1]),
            contactNumber('استلام حوالة', nums[2]),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Padding contactNumber(String title, String num) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              print(['object']);
              FlutterOpenWhatsapp.sendSingleMessage(num.substring(0), "");
            },
            child: Text(
              num,
            ),
          ),
          Text('  :'),
          Container(
              width: 110,
              child: Text(
                '$title',
                textAlign: TextAlign.right,
              ))
        ],
      ),
    );
  }

  Container buySale(
      BuildContext context, String title, String sale, String buy, Icon arrow) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          // color: Color(0xffc5cec3),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
          border: Border.all(color: Color(0xffc5cec3), width: 1.5)),
      child: Column(
        children: [
          Container(
            child: Text(title),
          ),
          Container(
            margin: EdgeInsets.all(8),
            height: 0.5,
            color: Color(0xffc5cec3),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffc5cec3),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffc5cec3), width: 1.5)),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xffc5cec3),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      child: Text(
                        'مبيع',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      padding: EdgeInsets.all(10),
                      child: Text(sale, textAlign: TextAlign.center),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                child: arrow,
              )),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffc5cec3),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffc5cec3), width: 1.5)),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xffc5cec3),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      child: Text(
                        'شراء',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      padding: EdgeInsets.all(10),
                      child: Text(buy, textAlign: TextAlign.center),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
