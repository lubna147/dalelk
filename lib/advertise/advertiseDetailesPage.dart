import 'package:dalelk/advertise/advertiseClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class advertiseDetailesPage extends StatelessWidget {
  advertiseClass temp;
  advertiseDetailesPage(this.temp);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Container(
          color: Colors.white,
          //      height: MediaQuery.of(context).size.height * 0.9999,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(alignment: Alignment.bottomCenter, children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(40)),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'images/loading.gif',
                      image: 'https://dalelalbab.xyz/${temp.imageUrl}',
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                  ),
                  Container(
                    color: Colors.white70,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(temp.owner),
                  )
                ]),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(temp.title),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                          onTap: () {
                            print(this.temp.phonenum);
                            FlutterOpenWhatsapp.sendSingleMessage(
                                this.temp.phonenum.substring(0),
                                "رأيت هذا المنتج على تطبيق دليلك" +
                                    "\n ${temp.title}");
                            print(this.temp.phonenum);
                          },
                          child: Text(temp.phonenum)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            temp.monyType,
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            temp.price,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(temp.location, textAlign: TextAlign.right),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                              child: Text(
                            temp.detailes,
                            textAlign: TextAlign.right,
                          )),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
