import 'package:alinea/models/main/item_navbar_model.dart';
import 'package:alinea/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var selectedIndex = 0.obs;
  List<ItemNavbarModel> items = [
    ItemNavbarModel(
        widget: HomePage(),
        icon: const Icon(Icons.home_outlined),
        title: "Beranda"),
    ItemNavbarModel(
      widget: HomePage(),
      icon: const Icon(Icons.inventory),
      title: "Notifikasi",
    ),
    ItemNavbarModel(
        widget: HomePage(),
        icon: const Icon(Icons.swap_vert_rounded),
        title: "Keranjang"),
    ItemNavbarModel(
      widget: HomePage(),
      icon: const Icon(Icons.location_on_outlined),
      title: "Profile",
    ),
  ];
}
