import 'package:dalelk/UserFiles/userAdverisersList.dart';
import 'package:dalelk/UserFiles/userInformations.dart';
import 'package:dalelk/advertise/advertiseClass.dart';
import 'package:dalelk/advertise/favouraiteAdvertise.dart';
import 'package:dalelk/advertise/normalAdvertise.dart';
import 'package:dalelk/extraTools/contactNumberPage.dart';
import 'package:dalelk/extraTools/internetConnectionTest.dart';
import 'package:dalelk/extraTools/loadingPage.dart';
import 'package:dalelk/extraTools/loginPage.dart';
import 'package:dalelk/extraTools/mySharedPreferences.dart';
import 'package:dalelk/extraTools/navigationPages.dart';
import 'package:dalelk/extraTools/noIternetConnection.dart';
import 'package:dalelk/extraTools/nothingToShow.dart';
import 'package:dalelk/extraTools/serverConnection.dart';
import 'package:dalelk/extraTools/serverConnection.dart';
import 'package:dalelk/extraTools/typesPage.dart';
import 'package:dalelk/medical/medicalItemTypeList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class adveriseMainList extends StatefulWidget {
  const adveriseMainList({Key? key}) : super(key: key);

  @override
  _adveriseMainListState createState() => _adveriseMainListState();
}

class _adveriseMainListState extends State<adveriseMainList> {
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
            isLogIn = false;
            MySharedPreferences.instance.setBooleanValue("firstTime", false);
            MySharedPreferences.instance.setBooleanValue("logIn", false);
          });
          Navigator.of(context).pop();
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute(builder: (context) => navigationPages()),
            (route) => false,
          );
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "تنبيـه",
        textAlign: TextAlign.right,
      ),
      content: Text("هل تريد تسجيل الخروج ؟",
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

  getData() {
    pharmaces = '';
    advers.clear();
    test.check().then((intenet) {
      if (intenet != null && intenet) {
        thereIsNoInternet = false;
        temp = loadingPage();
        if (pharmaces == '') {
          serverC.getPharmaces().then((value) {
            value.forEach((element) {
              pharmaces =
                  pharmaces + '\n' + element.name + ' : ' + element.location;
              setState(() {
                pharmaces = pharmaces.substring(1);
              });
            });
          });
        }

        if (advers.isEmpty) {
          serverC.getAllAdvertises().then((value) {
            if (value.isEmpty) {
              setState(() {
                temp = nothingToShow();
              });
            } else
              setState(() {
                advers.addAll(value);
                temp = mainBody();
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

  Future<void> refresh() async {
    advers.clear();
    serverC.getAllAdvertises().then((value) {
      if (value.isEmpty) {
        setState(() {
          temp = nothingToShow();
        });
      } else
        setState(() {
          advers.addAll(value);
          temp = mainBody();
        });
    });
  }

  ScrollController more = ScrollController();
  bool thereIsNoInternet = false;
  TextStyle menuItem = TextStyle(color: Colors.black54, fontSize: 15);
  late bool isLogIn = false;
  Widget temp = loadingPage();
  internetConnectionTest test = new internetConnectionTest();
  final globalKey = GlobalKey<ScaffoldState>();
  server serverC = new server();
  List<advertiseClass> advers = [];
  bool firstLogIn = false;
  String pharmaces = '';
  @override
  void initState() {
    temp = loadingPage();
    advers.clear();
    pharmaces = '';
    getData();
    super.initState();

    MySharedPreferences.instance
        .getBooleanValue("logIn")
        .then((value) => setState(() {
              isLogIn = value;
              print(value);
            }));
    super.initState();
    MySharedPreferences.instance
        .getBooleanValue("firstTime")
        .then((value) => setState(() {
              firstLogIn = value;
              print(value);
            }));
    more.addListener(() {
      if (more.position.pixels == more.position.maxScrollExtent) {
        moreData();
        print('im in taaaaaaaaaaaaaaiiiiiiiiiiiiiiiilllllllllll');
      } else {
        setState(() {
          tail = false;
        });
      }
    });
  }

  bool tail = false;
  Widget tailWedget = Text('');
  int fromHere = 0;
  moreData() {
    test.check().then((intenet) {
      if (intenet != null && intenet) {
        thereIsNoInternet = false;

        serverC.getMoreAdvertise(fromHere).then((value) {
          if (value.isEmpty) {
            setState(() {
              tail = true;
              tailWedget = Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MaterialCommunityIcons.cloud_off_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Text(
                    'لا يوجد مزيد من الاعلانات',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              );
            });
          } else
            setState(() {
              fromHere = value.last.id;
              advers.addAll(value);
              temp = mainBody();
            });
        });
      } else
        setState(() {
          tail = true;
          tailWedget = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                MaterialCommunityIcons.wifi_off,
                color: Colors.white,
              ),
              SizedBox(
                width: 24,
              ),
              Text(
                'تحقق من الاتصال بالانترنت',
                style: TextStyle(color: Colors.white),
              )
            ],
          );
          thereIsNoInternet = true;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (thereIsNoInternet) getData();
    return mainPage(context);
  }

  Scaffold mainPage(BuildContext context) {
    return Scaffold(
      key: globalKey,
      //  drawerEnableOpenDragGesture: false,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => globalKey.currentState!.openDrawer(),
              icon: Icon(Icons.menu))
        ], //
        title: Image.asset(
          'images/logo.png',
          height: 50,
          width: 50,
        ),
        centerTitle: true,
        elevation: 7,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => favouraiteAdvertise()));
          },
          icon: Icon(
            MaterialIcons.favorite,
            color: Color(0xffc5cec3),
            size: 30,
          ),
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  // color: Colors.white,
                  ),
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('images/logo.png'),
                  radius: 70,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.list,
                color: Colors.black54,
              ),
              title: Text(
                'التصنيفـات',
                style: menuItem,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => typesPage()));
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(
                MaterialCommunityIcons.heart_pulse,
                color: Colors.black54,
              ),
              title: Text(
                'الأقسام الطبية',
                style: menuItem,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => medicalItemTypeList()));
              },
            ),
            Visibility(
              visible: !isLogIn,
              child: ListTile(
                leading: Icon(
                  Icons.login,
                  color: Colors.black54,
                ),
                title: Text(
                  'تسجيل الدخول',
                  style: menuItem,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginPage()));
                },
              ),
            ),
            Visibility(
              visible: isLogIn,
              child: ListTile(
                leading: Icon(
                  MaterialCommunityIcons.logout,
                  color: Colors.black54,
                ),
                title: Text(
                  'تسجيل الخروج',
                  style: menuItem,
                ),
                onTap: () {
                  showAlertDialog(context);

                  // Update the state of the app.
                  // ...
                },
              ),
            ),
            Visibility(
              visible: isLogIn,
              child: ListTile(
                leading: Icon(
                  MaterialCommunityIcons.file_search,
                  color: Colors.black54,
                ),
                title: Text(
                  'إعلاناتي',
                  style: menuItem,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => userAdvertiseList()))
                      .then((value) {
                    getData();
                  });
                },
              ),
            ),
            Visibility(
              visible: firstLogIn,
              child: ListTile(
                leading: Icon(
                  MaterialCommunityIcons.file_search,
                  color: Colors.black54,
                ),
                title: Text(
                  'معلومات الحساب',
                  style: menuItem,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => userInformation()));
                },
              ),
            ),
            ListTile(
              leading: Icon(
                MaterialCommunityIcons.whatsapp,
                color: Colors.black54,
              ),
              title: Text(
                'تواصل معنا',
                style: menuItem,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => contactNumberPage()));
              },
            ),
          ],
        ),
      ),
      body: temp,
    );
  }

  Padding mainBody() {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Color(0xffc5cec3),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: FutureBuilder(
                  future: serverC.getPharmaces(),
                  builder: (context, projectSnap) {
                    if (projectSnap.connectionState == ConnectionState.none &&
                        projectSnap.hasData == null) {
                      //print('project snapshot data is: ${projectSnap.data}');
                      return Row(
                        children: [],
                      );
                    }

                    return Column(
                      //  mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'الصيدليات المناوبة',
                          style: TextStyle(fontSize: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  pharmaces,
                                  textAlign: TextAlign.right,
                                  //  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  })),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                refresh();
              },
              child: StaggeredGridView.countBuilder(
                controller: more,
                shrinkWrap: true,
                crossAxisCount: 1,
                itemCount: advers.length,
                itemBuilder: (BuildContext context, int index) =>
                    normalAdvertise(advers[index]),
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
