import 'package:dalelk/advertise/typeAdvertiseList.dart';
import 'package:flutter/material.dart';

class typeItem extends StatelessWidget {
  late String imageUrl;
  late String lable;
  late int id;
  typeItem(this.lable, this.imageUrl, this.id);
  navigateList(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => typeAdvertiseList(this.id, this.lable)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateList(context);
      },
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              /*    decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), topRight: Radius.circular(20)),*/

              color: Colors.white70,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(lable),
            )
          ],
        ),
      ),
    );
  }
}
