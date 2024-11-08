// ignore_for_file: must_be_immutable

import 'package:alinea/controller/notif/notifikasi_controller.dart';
import 'package:alinea/controller/home/book_controller.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/tabbar/tabbar_card.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                  ),
                  child: Row(
                    children: controller.listTab
                        .mapIndexed(
                          (index, element) => TabbarCard(
                            title: controller.listTab[index].tr,
                            isActive: controller.selectedIndex.value == index,
                            onTap: () {
                              if (index == controller.selectedIndex.value) {
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
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.2,
                            width: Get.width * 0.9,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 130,
                                  width: 90,
                                  child: Image.asset(
                                      AssetConstant.coverHarryPoter),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: Get.width * 0.63,
                                  height: 130,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "New Release: Anak Kecil Yang Kehilangan Pundaknya",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "Buku Novel “Anak Kecil yang Kehilangan Pundaknya”  kini tersedia di Alinea. Temukan cerita yang menarik.",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "10-27-2024",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.2,
                            width: Get.width * 0.9,
                            child: Row(
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0XFFC9D6F4),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15  ),
                                    child: SvgPicture.asset(
                                      AssetConstant.icDenda,
                                      fit: BoxFit.fill,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: Get.width * 0.63,
                                  height: 130,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: const [
                                            TextSpan(
                                              text:
                                                  "Denda Keterlambatan Pengembalian Buku denga ID Peminjaman",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " BKU109432.",
                                              style: TextStyle(
                                                color: Color(0XFF3A4BBB),
                                                fontWeight: FontWeight.w900,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "10-27-2024",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
