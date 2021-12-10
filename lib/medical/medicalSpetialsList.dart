import 'package:dalelk/extraTools/internetConnectionTest.dart';
import 'package:dalelk/extraTools/loadingPage.dart';
import 'package:dalelk/extraTools/loginPage.dart';
import 'package:dalelk/extraTools/noIternetConnection.dart';
import 'package:dalelk/extraTools/serverConnection.dart';
import 'package:dalelk/medical/medicalListItem.dart';
import 'package:dalelk/medical/medicalTypesClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class medicalSpetialsList extends StatefulWidget {
  const medicalSpetialsList({Key? key, String? title}) : super(key: key);

  @override
  _medicalSpetialsListState createState() => _medicalSpetialsListState();
}

internetConnectionTest test = new internetConnectionTest();
Widget temp = loadingPage();
final globalKey = GlobalKey<ScaffoldState>();
server serverC = new server();

class _medicalSpetialsListState extends State<medicalSpetialsList> {
  late List<medicalTypesClass> spe = [];
  @override
  Widget build(BuildContext context) {
    test.check().then((intenet) {
      if (intenet != null && intenet) {
        if (spe.isEmpty) {
          serverC.getDoctorTypes().then((value) {
            setState(() {
              spe.addAll(value);
              spe.removeAt(0);
              temp = mainPage();
            });
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'الأختصاصـات الطبيـة',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StaggeredGridView.countBuilder(
          padding: EdgeInsets.only(top: 8),
          shrinkWrap: true,
          crossAxisCount: 2,
          itemCount: spe.length,
          itemBuilder: (BuildContext context, int index) {
            return medicalListItem(
              spe[index],
              true,
            );
          },
          staggeredTileBuilder: (int index) => new StaggeredTile.count(1, 0.7),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
      ),
    );
  }
}
