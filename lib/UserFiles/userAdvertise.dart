import 'package:dalelk/UserFiles/newAdvertise.dart';
import 'package:dalelk/advertise/advertiseClass.dart';
import 'package:dalelk/advertise/advertiseDetailesPage.dart';
import 'package:dalelk/extraTools/internetConnectionTest.dart';
import 'package:dalelk/extraTools/mySharedPreferences.dart';
import 'package:dalelk/extraTools/serverConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

class userAdvertise extends StatefulWidget {
  final VoidCallback onDelete;
  advertiseClass temp;
  int index;
  userAdvertise(this.temp, this.index, {required this.onDelete});

  @override
  _userAdvertiseState createState() => _userAdvertiseState();
}

class _userAdvertiseState extends State<userAdvertise> {
  goToDetailes() {
    //   Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => advertiseDetailesPage(widget.temp)));
  }

  String advertiser = '';

  String title = '';

  String location = '';

  String phoneNum = '';

  TextStyle info = TextStyle(fontSize: 15, color: Colors.black54);
  server serverC = new server();
  int id = 0;
  Icon heart = Icon(
    MaterialIcons.favorite_border,
    color: Color(0xffc5cec3),
    size: 30,
  );
  internetConnectionTest test = new internetConnectionTest();
  @override
  Widget build(BuildContext context) {
    MySharedPreferences.instance.getIntegerValue("userId").then((value) {
      id = value;
    });
    return InkWell(
      onTap: () {
        goToDetailes();
      },
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FadeInImage.assetNetwork(
              placeholder: 'images/loading.gif',
              image: 'https://dalelalbab.xyz/${widget.temp.imageUrl}',
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
              child: Text(
                widget.temp.owner,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 16, left: 8),
              child: Text(
                widget.temp.title,
                textAlign: TextAlign.right,
                style: info,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 16, left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.temp.monyType,
                    textAlign: TextAlign.right,
                    style: info,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.temp.price,
                    textAlign: TextAlign.right,
                    style: info,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, right: 16, left: 8, bottom: 8),
              child: Text(
                widget.temp.location,
                textAlign: TextAlign.right,
                style: info,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            newAdvertise(widget.temp)))
                                .then((value) {
                              widget.onDelete();
                            });
                          },
                          icon: Icon(Icons.edit, color: Color(0xffc5cec3)))),
                  Container(
                    height: 40,
                    color: Color(0xffc5cec3),
                    width: 1,
                    //   height: MediaQuery.of(context).size.height,
                  ),
                  Expanded(
                      child: IconButton(
                          onPressed: () {
                            showAlertDialog(context);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Color(0xffc5cec3),
                          )))
                ],
              ),
            ),
          ],
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
        test.check().then((intenet) {
          if (intenet != null && intenet) {
            serverC.deletAdvertise(widget.temp.id).then((value) {
              if (value) {
                Fluttertoast.showToast(
                    msg: "تم الحذف",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 13);
                widget.onDelete();
              } else {
                Fluttertoast.showToast(
                    msg: "حدث خطأ . الرجاء المحاولة لاحقاً",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 13);
              }
            });
          } else {
            Fluttertoast.showToast(
                msg: " الرجاء التحقق من اتصالك بالانترنت",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 13);
          }
        });

        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "تنبيـه",
        textAlign: TextAlign.right,
      ),
      content: Text(" هل تريد حذف الإعلان؟",
          style: TextStyle(fontSize: 12), textAlign: TextAlign.right),
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
