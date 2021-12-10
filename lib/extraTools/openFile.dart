import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class openfile extends StatelessWidget {
  String url;
  openfile(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('جدول المناوبات'),
        centerTitle: true,
      ),
      body: SfPdfViewer.network(
        url,
      ),
    );
  }
}
