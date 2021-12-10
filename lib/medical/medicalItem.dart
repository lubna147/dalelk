import 'package:dalelk/extraTools/openFile.dart';
import 'package:dalelk/medical/medicalItemClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class medicalItem extends StatefulWidget {
  medicalItemClass temp;
  medicalItem(this.temp);

  @override
  _medicalItemState createState() => _medicalItemState();
}

class _medicalItemState extends State<medicalItem> {
  IconData medicalIcon = MaterialCommunityIcons.stethoscope;
  bool numVis = false;
  bool fileVis = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!(widget.temp.phoneNum == "")) numVis = true;
    if (!(widget.temp.filePath == "")) fileVis = true;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
          top: 8,
        ),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
            border: Border.all(color: Color(0xffc5cec3), width: 1)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            info(widget.temp.name, medicalIcon),
            //  info('', MaterialCommunityIcons.briefcase),
            info(widget.temp.location,
                MaterialCommunityIcons.map_marker_multiple),
            Visibility(
                visible: numVis,
                child: InkWell(
                  onTap: () {
                    FlutterOpenWhatsapp.sendSingleMessage(
                        widget.temp.phoneNum.substring(0), "");
                  },
                  child: info(
                      widget.temp.phoneNum, MaterialCommunityIcons.whatsapp),
                )),
            Visibility(
                visible: fileVis,
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => openfile(
                                  'https://dalelalbab.xyz/${widget.temp.filePath}')));
                    },
                    child: info(
                        'جدول المناوبات ', MaterialCommunityIcons.view_list))),
          ],
        ),
      ),
    );
  }

  Padding info(String info, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: Text(
            info,
            textAlign: TextAlign.right,
          )),
          SizedBox(
            width: 8,
          ),
          Icon(
            iconData,
            color: Color(0xffc5cec3),
          ),
        ],
      ),
    );
  }
}
