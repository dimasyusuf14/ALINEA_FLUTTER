import 'dart:io';
import 'package:alinea/controller/home/home_controller.dart';
import 'package:alinea/controller/main/main_controller.dart';
import 'package:alinea/models/main/widgets/item_navbar.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:get_storage/get_storage.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final MainController mainController = Get.put(MainController());
  final box = GetStorage(); // Initialize GetStorage

  

  @override
  Widget build(BuildContext context) {
    // Check if the user is logged in
    if (box.read('token') == null) {
      // Redirect to login page if not logged in
      Future.delayed(Duration.zero, () {
        Get.offAllNamed(RouteName.mainPage); // Replace with your login page route
      });
      return Container(); // Return empty container while redirecting
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  FadeTransition(
                opacity: animation,
                child: child,
              ),
              duration: const Duration(milliseconds: 300),
              child: Obx(
                () => Container(
                    key: ValueKey<int>(mainController.selectedIndex.value),
                    child: mainController
                        .items[mainController.selectedIndex.value].widget),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: Platform.isIOS ? 20 : 0),
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(color: Colors.grey, width: 1),
            )),
            child: Obx(
              () => Row(
                children: mainController.items
                    .mapIndexed(
                      (idx, _) => Expanded(
                          child: ItemNavbar(
                              model: mainController.items[idx],
                              isActive:
                                  mainController.selectedIndex.value == idx,
                              onTap: () {
                                if (idx == mainController.selectedIndex.value) {
                                } else {
                                  mainController.selectedIndex.value = idx;
                                }
                                logPrint("INDEX : $idx");
                              })),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
