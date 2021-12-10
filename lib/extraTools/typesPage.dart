import 'package:dalelk/extraTools/typeItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class typesPage extends StatelessWidget {
  typesPage({Key? key}) : super(key: key);
  List typesList = [
    new typeItem('ألبسة نسائية', 'images/women.jpg', 0),
    new typeItem('أحذية و حقائب', 'images/womenShose.jpeg', 1),
    new typeItem('ألبسة أطفال', 'images/childrens.jpg', 2),
    new typeItem('ألبسة رجالية', 'images/men.jpg', 3),
    new typeItem('أحذية رجالية', 'images/menShose2.jpg', 4),
    new typeItem('صرافة و حوالات', 'images/mony.jpg', 5),
    new typeItem('مفروشات', 'images/salon.jpg', 6),
    new typeItem('تجارة سيارات', 'images/car.jpg', 7),
    new typeItem('مكياج و اكسسوارات', 'images/makeup.jpg', 8),
    new typeItem('مطاعم و كافيهات', 'images/resturant.jpg', 9),
    new typeItem('أقمشة و مستلزماتها', 'images/fabric.jpg', 10),
    new typeItem('عقارات و تعهدات', 'images/buildings.jpeg', 11),
    new typeItem('معاهد و مؤسسات تعليمية', 'images/school.png', 12),
    new typeItem('تصميم داخلي', 'images/boards.jpg', 13),
    new typeItem('مأكولات', 'images/fast-food.jpg', 14),
    new typeItem('ألعاب و هدايا', 'images/gifts.jpg', 15),
    new typeItem('مجوهرات', 'images/gold.jpg', 16),
    new typeItem('أجهزة الكترونية', 'images/mobile.jpg', 17),
    new typeItem('أجهرة كهربائية', 'images/elcetrics.jpg', 18),
    new typeItem('مكتبات', 'images/note.jpeg', 19),
    new typeItem('نقل و سفريات', 'images/bus.jpg', 20),
    new typeItem('أدوات منزلية', 'images/kitchen.jpg', 21),
    new typeItem('سيارات مياه', 'images/water.png', 22),
    new typeItem('طباعة و إعلان', 'images/colors.jpg', 23),
    new typeItem('حلويات و طبخ عربي', 'images/sweets.jpg', 24),
    new typeItem('خردوات', 'images/hummer.jpg', 25),
    new typeItem('برمجة وتصميم', 'images/code.jpeg', 26),
    new typeItem('خدمات توصيل', 'images/taxi.jpg', 27),
    new typeItem('تجارة جملة', 'images/wholesale.jpg', 28),
    new typeItem('سوبر ماركت', 'images/market.jpg', 29),
    new typeItem('متفرقات', 'images/unknown.png', 30)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: StaggeredGridView.countBuilder(
          shrinkWrap: true,
          crossAxisCount: 2,
          itemCount: typesList.length,
          itemBuilder: (BuildContext context, int index) => typesList[index],
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
      ),
    );
  }
}
