import 'package:dalelk/medical/medicalItemList.dart';
import 'package:dalelk/medical/medicalSpetialsList.dart';
import 'package:dalelk/medical/medicalTypesClass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class medicalListItem extends StatelessWidget {
  medicalTypesClass temp;
  bool type = false;

  medicalListItem(this.temp, this.type);
  _navigateToOtherPage(BuildContext context) {
    if (type == false && this.temp.id == 0) {
      // Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => medicalSpetialsList()));
    } else {
      //  Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => medicalItemList(temp, type)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _navigateToOtherPage(context);
      },
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              /*  margin: EdgeInsets.only(
                    top: 8,
                  ),*/
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Color(0xffc5cec3),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  border: Border.all(color: Color(0xffc5cec3), width: 1)),
            ),
            Container(
              /*  margin: EdgeInsets.only(
                    top: 8,
                  ),*/
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40)),
                  border: Border.all(color: Color(0xffc5cec3), width: 1)),
            ),
            Text(
              this.temp.title,
              style: TextStyle(
                  color: Color(0xffc5cec3),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
