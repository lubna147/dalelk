import 'dart:async';

import 'package:dalelk/UserFiles/userAdverisersList.dart';
import 'package:dalelk/advertise/advertiseMainList.dart';
import 'package:dalelk/extraTools/loginPage.dart';
import 'package:dalelk/extraTools/mySharedPreferences.dart';
import 'package:dalelk/extraTools/typesPage.dart';
import 'package:dalelk/jobs/jobList.dart';
import 'package:dalelk/medical/medicalItemTypeList.dart';
import 'package:dalelk/mony/monyPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/TabItem.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

class navigationPages extends StatefulWidget {
  const navigationPages({Key? key}) : super(key: key);

  @override
  _navigationPagesState createState() => _navigationPagesState();
}

class _navigationPagesState extends State<navigationPages>
    with TickerProviderStateMixin {
  late MotionTabController _tabController;

  bool canback = false;
  @override
  void initState() {
    super.initState();
    _tabController = MotionTabController(initialIndex: 0, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future<bool> _onWillPop() async {
    if (canback == true) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      setState(() {
        _tabController.index = 0;
        canback = true;
      });
    }

    Timer(Duration(seconds: 2), () {
      setState(() {
        canback = false;
      });
    });
    //
    return canback;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MotionTabBar(
          labels: ["إعلانات", "عملات", "فرص عمل"],
          initialSelectedTab: "إعلانات",
          tabIconColor: Color(0xffc5cec3),
          tabSelectedColor: Color(0xffc5cec3),
          onTabItemSelected: (int value) {
            print(value);
            setState(() {
              _tabController.index = value;
            });
          },
          icons: [Icons.home, Ionicons.md_cash, Icons.search],
          textStyle: TextStyle(color: Color(0xffc5cec3), fontSize: 10),
        ),
        body: MotionTabBarView(
            controller: _tabController,
            children: [adveriseMainList(), monyPage(), jobList()]));
  }
}
