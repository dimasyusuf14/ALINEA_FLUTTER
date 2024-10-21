// import 'package:flutter/material.dart';

// class ItemNavbarModel {
//   Icon icon;
//   String title;
//   Widget widget;

//   ItemNavbarModel(
//       {required this.widget, required this.icon, required this.title});
// }

import 'package:flutter/material.dart';

class ItemNavbarModel {
  String icon; // Change Icon to Widget
  String title;
  Widget widget;

  ItemNavbarModel({
    required this.widget,
    required this.icon, // Now it's of type Widget
    required this.title,
  });
}
