import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class loadingPage extends StatelessWidget {
  const loadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          EvilIcons.spinner,
          color: Colors.black45,
          size: 40,
        ),
      ),
    );
  }
}
