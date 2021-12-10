import 'package:dalelk/advertise/advertiseClass.dart';
import 'package:dalelk/advertise/normalAdvertise.dart';
import 'package:dalelk/extraTools/internetConnectionTest.dart';
import 'package:dalelk/extraTools/loadingPage.dart';
import 'package:dalelk/extraTools/loginPage.dart';
import 'package:dalelk/extraTools/mySharedPreferences.dart';
import 'package:dalelk/extraTools/noIternetConnection.dart';
import 'package:dalelk/extraTools/nothingToShow.dart';
import 'package:dalelk/extraTools/serverConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class favouraiteAdvertise extends StatefulWidget {
  const favouraiteAdvertise({Key? key}) : super(key: key);

  @override
  _favouraiteAdvertiseState createState() => _favouraiteAdvertiseState();
}

class _favouraiteAdvertiseState extends State<favouraiteAdvertise> {
  internetConnectionTest test = new internetConnectionTest();
  Widget temp = loadingPage();
  List<advertiseClass> advers = [];
  server serverC = new server();
  TextEditingController search = new TextEditingController();
  List<int> listInt = [0];
  getdata() {
    setState(() {
      temp = loadingPage();
      listInt = [0];
      advers.clear();
      MySharedPreferences.instance.getStringList('fav').then((value) {
        //    listInt.add(0);
        listInt = value!.map(int.parse).toList();
        print(listInt);
      });
    });

    test.check().then((intenet) {
      if (intenet != null && intenet) {
        if (advers.isEmpty) {
          serverC.getfavouraiteAdvertise(listInt).then((value) {
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
        }
      } else
        setState(() {
          temp = noInternetConnection();
        });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return temp;
  }

  Scaffold mainPage() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('المفضـلة'),
        centerTitle: true,
        elevation: 7,
        backgroundColor: Colors.white,
        leading: BackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            /*   Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: search,
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (value) {
                  advers.clear();
                  serverC
                      .getAdvertisebyTypeSearch(widget.id, value)
                      .then((value) {
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
                    //      hintText: this.hint,
                    hintStyle: TextStyle(color: Colors.black26),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
                onChanged: (value) {
                  if (value == '') {
                    FocusScope.of(context).unfocus();
                    getdata();
                  }
                },
              ),
            ),
         */
            Expanded(
              child: StaggeredGridView.countBuilder(
                shrinkWrap: true,
                crossAxisCount: 1,
                itemCount: advers.length,
                itemBuilder: (BuildContext context, int index) =>
                    normalAdvertise(advers[index]),
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
