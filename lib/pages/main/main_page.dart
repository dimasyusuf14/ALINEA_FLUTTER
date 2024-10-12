import 'dart:io';
import 'package:alinea/controller/main/main_controller.dart';
import 'package:alinea/models/main/widgets/item_navbar.dart';
import 'package:alinea/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  final MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
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
              top: BorderSide(color: Colors.red, width: 1),
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
