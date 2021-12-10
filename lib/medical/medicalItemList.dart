import 'package:dalelk/extraTools/internetConnectionTest.dart';
import 'package:dalelk/extraTools/loadingPage.dart';
import 'package:dalelk/extraTools/loginPage.dart';
import 'package:dalelk/extraTools/noIternetConnection.dart';
import 'package:dalelk/extraTools/nothingToShow.dart';
import 'package:dalelk/extraTools/serverConnection.dart';
import 'package:dalelk/jobs/jobItem.dart';
import 'package:dalelk/medical/medicalItem.dart';
import 'package:dalelk/medical/medicalItemClass.dart';
import 'package:dalelk/medical/medicalTypesClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class medicalItemList extends StatefulWidget {
  medicalTypesClass temp;
  bool type;
  medicalItemList(this.temp, this.type);

  @override
  _medicalItemListState createState() => _medicalItemListState();
}

internetConnectionTest test = new internetConnectionTest();
Widget temp = loadingPage();
server serverC = new server();
TextEditingController searchCont = new TextEditingController();

class _medicalItemListState extends State<medicalItemList> {
  search(String s) {
    meds.clear();
    if (!widget.type) {
      serverC.getMedByTypeSearch(widget.temp.id, s).then((value) {
        if (value.isEmpty)
          setState(() {
            temp = nothingToShow();
          });
        else
          setState(() {
            meds.addAll(value);
            print('i fill it 1');
            temp = mainPage();
          });
      });
    } else {
      serverC.getMedBySpectialSearch(widget.temp.id, s).then((value) {
        if (value.isEmpty)
          setState(() {
            temp = nothingToShow();
          });
        else
          setState(() {
            print(value);
            meds.addAll(value);
            print('i fill it 2');
            temp = mainPage();
          });
      });
    }
  }

  getData() {
    test.check().then((intenet) {
      if (intenet != null && intenet) {
        if (meds.isEmpty) {
          print('emptyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
          print(widget.type);
          if (!widget.type) {
            serverC.getMedicalsByType(widget.temp.id).then((value) {
              if (value.isEmpty)
                setState(() {
                  temp = nothingToShow();
                });
              else
                setState(() {
                  meds.addAll(value);
                  print('i fill it 1');
                  temp = mainPage();
                });
            });
          } else {
            serverC.getMedicalsBySpectial(widget.temp.id).then((value) {
              if (value.isEmpty)
                setState(() {
                  temp = nothingToShow();
                });
              else
                setState(() {
                  print(value);
                  meds.addAll(value);
                  print('i fill it 2');
                  temp = mainPage();
                });
            });
          }
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
    temp = loadingPage();
    print('initial State');
    searchCont.text = '';
    meds.clear();
    //   getData();
  }

  List<medicalItemClass> meds = [];
  @override
  Widget build(BuildContext context) {
    getData();
    print('build');
    return temp;
  }

  Scaffold mainPage() {
    return Scaffold(
      /*  floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    floatingActionButton: FloatingActionButton(
      onPressed: null,
      backgroundColor: Color(0xffc5cec3),
      child: Icon(
        Icons.add,
        color: Colors.white60,
      ),
    ),*/
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '',
          style: TextStyle(color: Colors.black54),
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              controller: searchCont,
              onFieldSubmitted: (value) {
                search(value);
              },
              textInputAction: TextInputAction.search,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                  hintText: 'انقر للبحث',
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                  //      hintText: this.hint,
                  hintStyle: TextStyle(color: Colors.black26),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.only(top: 8),
                shrinkWrap: true,
                crossAxisCount: 1,
                itemCount: meds.length,
                itemBuilder: (BuildContext context, int index) =>
                    medicalItem(meds[index]),
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 4.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
