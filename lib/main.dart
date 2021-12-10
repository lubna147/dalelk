import 'package:dalelk/UserFiles/newAdvertise.dart';
import 'package:dalelk/UserFiles/userAdverisersList.dart';
import 'package:dalelk/UserFiles/userInformations.dart';
import 'package:dalelk/advertise/advertiseClass.dart';
import 'package:dalelk/advertise/advertiseDetailesPage.dart';
import 'package:dalelk/advertise/advertiseMainList.dart';
import 'package:dalelk/advertise/favouraiteAdvertise.dart';
import 'package:dalelk/advertise/normalAdvertise.dart';
import 'package:dalelk/extraTools/contactNumberPage.dart';
import 'package:dalelk/extraTools/loginPage.dart';
import 'package:dalelk/extraTools/mySharedPreferences.dart';
import 'package:dalelk/extraTools/navigationPages.dart';
import 'package:dalelk/extraTools/openFile.dart';
import 'package:dalelk/extraTools/typesPage.dart';
import 'package:dalelk/jobs/addNewJob.dart';
import 'package:dalelk/jobs/jobItem.dart';
import 'package:dalelk/jobs/jobList.dart';
import 'package:dalelk/medical/medicalItemList.dart';
import 'package:dalelk/medical/medicalItemTypeList.dart';
import 'package:dalelk/medical/medicalSpetialsList.dart';
import 'package:dalelk/mony/monyPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //  inputDecorationTheme:InputDecorationTheme(border: Border.) ,
          primaryColor: Colors.white,
          //    primarySwatch: Colors.blue,
        ),
        home: navigationPages());
  }
}
/*
shared variable 
////////////////////////////dalelalbab.xyz/api/updateAdvertise/72?_method=PUT
"logIn"
"userId"
"palceName",
"place"
"phone"
'DuSySale'
'TrSySale'
'DuTrSale'
"userName"
"passWord"

main color Color(0xffc5cec3)

*/
