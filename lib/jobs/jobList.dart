import 'package:dalelk/extraTools/internetConnectionTest.dart';
import 'package:dalelk/extraTools/loadingPage.dart';
import 'package:dalelk/extraTools/loginPage.dart';
import 'package:dalelk/extraTools/noIternetConnection.dart';
import 'package:dalelk/extraTools/nothingToShow.dart';
import 'package:dalelk/extraTools/serverConnection.dart';
import 'package:dalelk/jobs/addNewJob.dart';
import 'package:dalelk/jobs/jobClass.dart';
import 'package:dalelk/jobs/jobItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class jobList extends StatefulWidget {
  const jobList({Key? key}) : super(key: key);

  @override
  _jobListState createState() => _jobListState();
}

internetConnectionTest test = new internetConnectionTest();
Widget temp = loadingPage();
List<jobClass> jobs = [];
server serverC = new server();
bool thereIsNoInternet = false;

class _jobListState extends State<jobList> {
  getdata() {
    setState(() {
      jobs.clear();
      //  temp = loadingPage();
    });

    test.check().then((intenet) {
      if (intenet != null && intenet) {
        temp = loadingPage();
        if (jobs.isEmpty) {
          serverC.getJobs().then((value) {
            if (value.isEmpty) {
              setState(() {
                temp = nothingToShow();
              });
            } else
              setState(() {
                jobs.addAll(value);
                temp = mainBody(context);
                thereIsNoInternet = false;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    temp = loadingPage();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    if (thereIsNoInternet) getdata();
    return mainPage(context);
  }

  Scaffold mainPage(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => addNewJob()))
              .then((value) {
            getdata();
          });
        },
        backgroundColor: Color(0xffc5cec3),
        child: Icon(
          Icons.add,
          color: Colors.white60,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'فـرص الـعمل',
          style: TextStyle(color: Colors.black54),
        ),
      ),
      body: temp,
    );
  }

  Padding mainBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.search,
            textAlign: TextAlign.right,
            onChanged: (value) {
              if (value == '') {
                FocusScope.of(context).unfocus();
                getdata();
              }
            },
            onFieldSubmitted: (value) {
              jobs.clear();
              serverC.getJobsSearch(value).then((value) {
                if (value.isNotEmpty) {
                  setState(() {
                    jobs.addAll(value);
                    temp = mainBody(context);
                  });
                } else {
                  setState(() {
                    temp = nothingToShow();
                  });
                }
              });
            },
            decoration: InputDecoration(
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
              itemCount: jobs.length,
              itemBuilder: (BuildContext context, int index) =>
                  jobItem(jobs[index]),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 4.0,
            ),
          )
        ],
      ),
    );
  }
}
