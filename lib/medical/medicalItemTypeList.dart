import 'package:dalelk/medical/medicalListItem.dart';
import 'package:dalelk/medical/medicalTypesClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class medicalItemTypeList extends StatefulWidget {
  const medicalItemTypeList({Key? key, String? title}) : super(key: key);

  @override
  _medicalItemTypeListState createState() => _medicalItemTypeListState();
}

class _medicalItemTypeListState extends State<medicalItemTypeList> {
  List<medicalTypesClass> list = [
    new medicalTypesClass(0, 'عيــادات'),
    new medicalTypesClass(1, 'مشـافي'),
    new medicalTypesClass(2, 'صيدليـات'),
    new medicalTypesClass(3, 'ممرضيـن'),
    new medicalTypesClass(4, 'مراكـز صحيـة')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'الأقسـام الـطبية',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StaggeredGridView.countBuilder(
          padding: EdgeInsets.only(top: 8),
          shrinkWrap: true,
          crossAxisCount: 1,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) => medicalListItem(
            list[index],
            false,
          ),
          staggeredTileBuilder: (int index) => new StaggeredTile.count(1, 0.3),
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 8.0,
        ),
      ),
    );
  }
}
