import 'package:dalelk/jobs/jobClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class jobItem extends StatefulWidget {
  jobClass job;
  jobItem(this.job);

  @override
  _jobItemState createState() => _jobItemState();
}

class _jobItemState extends State<jobItem> {
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
            info(widget.job.boss, Foundation.torsos_all),
            info(widget.job.job, MaterialCommunityIcons.briefcase),
            info(widget.job.location,
                MaterialCommunityIcons.map_marker_multiple),
            InkWell(
                onTap: () {
                  FlutterOpenWhatsapp.sendSingleMessage(
                      widget.job.phoneNumber.substring(0),
                      "رأيت هذا الشاغر  على تطبيق دليلك" +
                          "\n ${widget.job.job}");
                },
                child: info(
                    widget.job.phoneNumber, MaterialCommunityIcons.whatsapp)),
            infoDetaile(
                widget.job.detailes, MaterialCommunityIcons.file_multiple),
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

  Padding infoDetaile(String info, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: SelectableText(
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
