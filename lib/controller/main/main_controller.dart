import 'package:alinea/models/main/item_navbar_model.dart';
import 'package:alinea/pages/home/home_page.dart';
import 'package:alinea/pages/notif/notifikasi.dart';
import 'package:alinea/utilities/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var selectedIndex = 0.obs;
  var profilePicture = 'assets/images/default_profile_picture.png'.obs;

  void updateProfilePicture(String newPicture) {
    profilePicture.value = newPicture;
  }

  List<ItemNavbarModel> items = [
    ItemNavbarModel(
      widget: HomePage(),
      icon: AssetConstant.icBeranda, // SVG icon
      title: "Beranda",
    ),
    ItemNavbarModel(
      widget: NotifikasiPage(),
      icon: AssetConstant.icNotif, // Regular Icon
      title: "Notifikasi",
    ),
    ItemNavbarModel(
      widget: HomePage(),
      icon: AssetConstant.icKeranjang, // Regular Icon
      title: "Keranjang",
    ),
    ItemNavbarModel(
      widget: HomePage(),
      icon: AssetConstant.icProfile, // Regular Icon
      title: "Profile",
    ),
  ];
}
