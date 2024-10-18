// import 'package:alinea/models/main/item_navbar_model.dart';
// import 'package:alinea/pages/home/home_page.dart';
// import 'package:alinea/utilities/asset_constant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';

// class MainController extends GetxController {
//   var selectedIndex = 0.obs;
//   List<ItemNavbarModel> items = [
//     ItemNavbarModel(
//         widget: HomePage(),
//         icon: SvgPicture.asset(AssetConstant.icBeranda),
//         title: "Beranda"),
//     ItemNavbarModel(
//       widget: HomePage(),
//       icon: const Icon(Icons.inventory),
//       title: "Notifikasi",
//     ),
//     ItemNavbarModel(
//         widget: HomePage(),
//         icon: const Icon(Icons.swap_vert_rounded),
//         title: "Keranjang"),
//     ItemNavbarModel(
//       widget: HomePage(),
//       icon: const Icon(Icons.location_on_outlined),
//       title: "Profile",
//     ),
//   ];
// }

import 'package:alinea/models/main/item_navbar_model.dart';
import 'package:alinea/pages/home/home_page.dart';
import 'package:alinea/pages/notif/notifikasi.dart';
import 'package:alinea/utilities/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var selectedIndex = 0.obs;
  List<ItemNavbarModel> items = [
    ItemNavbarModel(
      widget: HomePage(),
      icon: SvgPicture.asset(AssetConstant.icBeranda), // SVG icon
      title: "Beranda",
    ),
    ItemNavbarModel(
      widget: NotifikasiPage(),
      icon: SvgPicture.asset(AssetConstant.icNotif), // Regular Icon
      title: "Notifikasi",
    ),
    ItemNavbarModel(
      widget: HomePage(),
      icon: SvgPicture.asset(AssetConstant.icKeranjang), // Regular Icon
      title: "Keranjang",
    ),
    ItemNavbarModel(
      widget: HomePage(),
      icon: const Icon(Icons.location_on_outlined), // Regular Icon
      title: "Profile",
    ),
  ];
}
