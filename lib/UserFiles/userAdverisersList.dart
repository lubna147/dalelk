import 'dart:async';

import 'package:dalelk/UserFiles/newAdvertise.dart';
import 'package:dalelk/UserFiles/userAdvertise.dart';
import 'package:dalelk/advertise/advertiseClass.dart';
import 'package:dalelk/extraTools/internetConnectionTest.dart';
import 'package:dalelk/extraTools/loadingPage.dart';
import 'package:dalelk/extraTools/mySharedPreferences.dart';
import 'package:dalelk/extraTools/noIternetConnection.dart';
import 'package:dalelk/extraTools/nothingToShow.dart';
import 'package:dalelk/extraTools/serverConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class userAdvertiseList extends StatefulWidget {
  userAdvertiseList();
  @override
  _userAdvertiseListState createState() => _userAdvertiseListState();
}

Widget temp = loadingPage();
List<advertiseClass> advers = [];
server serverC = new server();
internetConnectionTest test = new internetConnectionTest();
int id = 0;
TextEditingController search = new TextEditingController();
bool thereIsNoInternet = false;
String userName = '';
String passWord = '';

class _userAdvertiseListState extends State<userAdvertiseList> {
  getData() {
    advers.clear();
    //   temp = loadingPage();
    test.check().then((intenet) {
      if (intenet != null && intenet) {
        thereIsNoInternet = false;
        setState(() {
          temp = loadingPage();
        });
        if (advers.isEmpty) {
          serverC.getAdvertisebyUser(id).then((value) {
            if (value.isNotEmpty) {
              setState(() {
                advers.addAll(value);
                temp = mainBody();
                thereIsNoInternet = false;
              });
            } else
              setState(() {
                temp = nothingToShow();
              });
          });
        }
      } else
        setState(() {
          temp = noInternetConnection();
          thereIsNoInternet = true;
        });
    });
  }

  void initState() {
    // TODO: implement initState
    MySharedPreferences.instance.getIntegerValue("userId").then((value) {
      id = value;
    });
    MySharedPreferences.instance.getStringValue("userName").then((value) {
      userName = value;
    });
    MySharedPreferences.instance.getStringValue("passWord").then((value) {
      passWord = value;
    });
    test.check().then((intenet) {
      if (intenet != null && intenet)
        serverC.getUserId(userName, passWord).then((value) {
          print(userName + passWord);
          print(value);
          if (value.id != 0) {
            ;
          } else {
            Fluttertoast.showToast(
                msg: "تم إلغاء هذا الحساب الرجاء التواصل مع المسؤولين",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 13);
            Navigator.pop(context);
            setState(() {
              MySharedPreferences.instance.setBooleanValue("logIn", false);
            });
          }
        });
    });

    super.initState();
    MySharedPreferences.instance.getIntegerValue("userId").then((value) {
      id = value;
    });
    advers.clear();
    temp = loadingPage();
    getData();
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (thereIsNoInternet) getData();
    return mainPage();
  }

  Scaffold mainPage() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 7,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Color(0xffc5cec3),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => newAdvertise(new advertiseClass(
                      0, '', '', '', '', '', '', '', '')))).then((value) {
            getData();
          });
        },
        backgroundColor: Color(0xffc5cec3),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: temp,
    );
  }

  Column mainBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 8,
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: search,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (value) {
                advers.clear();
                serverC.getAdvertisebyUserSearch(id, value).then((value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      advers.addAll(value);
                      temp = mainPage();
                    });
                  } else {
                    setState(() {
                      temp = nothingToShow();
                    });
                  }
                });
              },
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                  hintText: 'انقر للبحث',
                  hintStyle: TextStyle(color: Colors.black26),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
        ),
        Expanded(
          child: StaggeredGridView.countBuilder(
            padding: EdgeInsets.only(top: 8),
            shrinkWrap: true,
            crossAxisCount: 1,
            itemCount: advers.length,
            itemBuilder: (BuildContext context, int index) => userAdvertise(
              advers[index],
              index,
              onDelete: () => removeItem(index),
            ),
            staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
        )
      ],
    );
  }

  void removeItem(int index) {
    setState(() {
      temp = loadingPage();
    });
    print(advers.length);
    advers.clear();
    serverC.getAdvertisebyUser(id).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          advers.addAll(value);
          temp = mainBody();
        });
      } else
        setState(() {
          temp = nothingToShow();
        });
    });
  }
}
