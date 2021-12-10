import 'package:dalelk/advertise/advertiseClass.dart';
import 'package:dalelk/advertise/advertiseDetailesPage.dart';
import 'package:dalelk/advertise/typeAdvertiseList.dart';
import 'package:dalelk/extraTools/mySharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class normalAdvertise extends StatefulWidget {
  advertiseClass temp;
  normalAdvertise(this.temp);

  @override
  _normalAdvertiseState createState() => _normalAdvertiseState();
}

class _normalAdvertiseState extends State<normalAdvertise> {
  List<int> listInt = [];

  goToDetailes() {
    //   Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => advertiseDetailesPage(widget.temp)));
  }

  TextStyle info = TextStyle(fontSize: 15, color: Colors.black54);
  Icon heart = Icon(
    MaterialIcons.favorite_border,
    color: Color(0xffc5cec3),
    size: 30,
  );
  String name = '';
  String title = '';
  String p = '';
  String ph = '';
  bool isFav = false;
  bool _loaded = false;
  // var img = Image.network('https://dalelalbab.xyz/${widget.temp.imageUrl}');
  var placeholder = AssetImage('images/loading.gif');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //img.image.resolve(ImageConfiguration().));

    MySharedPreferences.instance.getStringList('fav').then((value) {
      listInt = value!.map(int.parse).toList();
      if (listInt.contains(widget.temp.id))
        setState(() {
          heart = Icon(
            MaterialIcons.favorite,
            color: Color(0xffc5cec3),
            size: 30,
          );
          isFav = true;
        });
    });
  }

  late List<String> ids;
  @override
  Widget build(BuildContext context) {
    print('objectrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
    print(widget.temp.owner);
    print(widget.temp.location);

    return InkWell(
      onTap: () {
        goToDetailes();
      },
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
              child: Text(
                widget.temp.owner,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Stack(
              children: [
                FadeInImage.assetNetwork(
                  placeholder: 'images/loading.gif',
                  image: 'https://dalelalbab.xyz/${widget.temp.imageUrl}',
                  fit: BoxFit.contain,
                ),
                IconButton(
                    onPressed: () {
                      if (isFav) {
                        setState(() {
                          heart = Icon(
                            MaterialIcons.favorite_border,
                            color: Color(0xffc5cec3),
                            size: 30,
                          );
                          isFav = false;
                        });
                        listInt.remove(widget.temp.id);
                        ids = listInt.map((e) => e.toString()).toList();
                        MySharedPreferences.instance.setStringList('fav', ids);
                      } else {
                        setState(() {
                          heart = Icon(
                            MaterialIcons.favorite,
                            color: Color(0xffc5cec3),
                            size: 30,
                          );
                        });
                        listInt.add(widget.temp.id);

                        ids = listInt.map((e) => e.toString()).toList();
                        MySharedPreferences.instance.setStringList('fav', ids);
                      }
                    },
                    icon: heart),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 16, left: 8),
              child: Text(
                widget.temp.title,
                textAlign: TextAlign.right,
                style: info,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 16, left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.temp.monyType,
                    textAlign: TextAlign.right,
                    style: info,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.temp.price,
                    textAlign: TextAlign.right,
                    style: info,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, right: 16, left: 8, bottom: 8),
              child: Text(
                widget.temp.location,
                textAlign: TextAlign.right,
                style: info,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
