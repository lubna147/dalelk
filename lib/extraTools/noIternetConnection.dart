import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class noInternetConnection extends StatelessWidget {
  const noInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_off,
              size: 40,
              color: Colors.black54,
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'لا يوجد اتصال بالانترنت',
              style: TextStyle(color: Colors.black54, fontSize: 20),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'قم بالتحقق من الاتصال بالانترنت',
              style: TextStyle(color: Colors.black38, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
