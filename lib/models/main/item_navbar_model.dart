

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

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

