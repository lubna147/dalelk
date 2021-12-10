import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class nothingToShow extends StatelessWidget {
  const nothingToShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Feather.alert_triangle,
              color: Colors.black45,
              size: 70,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'لايوجد معلومات لعرضها',
              style: TextStyle(fontSize: 20, color: Colors.black45),
            )
          ],
        ),
      ),
    );
  }
}
