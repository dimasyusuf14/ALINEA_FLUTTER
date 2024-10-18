// ignore_for_file: must_be_immutable

import 'package:alinea/controller/notif/notifikasi_controller.dart';
import 'package:alinea/controller/home/home_controller.dart';
import 'package:alinea/utilities/utilities.dart';
import 'package:alinea/widgets/tabbar/tabbar_card.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class NotifikasiPage extends StatelessWidget {
  NotifikasiPage({super.key});

  NotifikasiController controller = Get.put(NotifikasiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (controller.loadingDetail.value == DataLoad.loading) {
                return Text(
                  "ini loading",
                  style: TextStyle(
                    fontSize: 32.0,
                  ),
                );
              } else if (controller.loadingDetail.value == DataLoad.failed) {
                return Text(
                  "INi ERROR",
                  style: TextStyle(
                    fontSize: 32.0,
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50.0,
                      ),
                      Obx(
                        () => Center(
                          child: Container(
                            width: Get.width * 0.7,
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.red,
                            ),
                            child: Row(
                              children: controller.listTab
                                  .mapIndexed(
                                    (index, element) => TabbarCard(
                                      title: controller.listTab[index].tr,
                                      isActive:
                                          controller.selectedIndex.value == index,
                                      onTap: () {
                                        if (index ==
                                            controller.selectedIndex.value) {
                                        } else {
                                          controller.selectedIndex.value = index;
                                        }
                                      },
                                      isFirstIndex: index == 0,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => controller.selectedIndex.value == 0
                            ? Text("ininotif")
                            : Text("ini pengaturan"),
                      ),
                      Text(
                        controller.detail.value!.attributes.Title,
                        style: TextStyle(
                          fontSize: 32.0,
                        ),
                      ),
                      HtmlWidget(
                        controller.detail.value!.attributes.Content,
                      ),
                    ],
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
