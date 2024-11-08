import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/widgets/button/button_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomModal(BuildContext context) {
  OverlayState overlayState = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          overlayEntry.remove(); // Menutup modal saat area luar ditekan
        },
        child: Stack(
          children: [
            Container(
              color: Colors.black54, // Background semi-transparan
            ),
            Positioned(
              top: Get.height * 0.15,
              left: Get.width * 0.7,
              right: Get.width * 0.06,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 150,
                  height: Get.height * 0.55,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonCategory(
                        onTap: () {
                          Get.toNamed(RouteName.mainPage);
                        },
                        icon: AssetConstant.icAksi,
                        bgcolor: Color(0XFFFFDADA),
                        iccolor: Color(0XFFFF0000),
                        title: "Aksi",
                      ),
                      ButtonCategory(
                        onTap: () {
                          Get.toNamed(RouteName.mainPage);
                        },
                        icon: AssetConstant.icFiksi,
                        bgcolor: Color(0XFFC3FFD4),
                        iccolor: Color(0XFF009F2C),
                        title: "Fiksi",
                      ),
                      ButtonCategory(
                        onTap: () {
                          Get.toNamed(RouteName.mainPage);
                        },
                        icon: AssetConstant.icRomance,
                        bgcolor: Color(0XFFFFE0F6),
                        iccolor: Color(0XFFFF00B8),
                        title: "Romansa",
                      ),
                      ButtonCategory(
                        onTap: () {
                          Get.toNamed(RouteName.mainPage);
                        },
                        icon: AssetConstant.icHoror,
                        bgcolor: Color(0XFFCFE5FF),
                        iccolor: Color(0XFF0075FF),
                        title: "Horor",
                      ),
                      ButtonCategory(
                        onTap: () {
                          Get.toNamed(RouteName.mainPage);
                        },
                        icon: AssetConstant.icSejarah,
                        bgcolor: Color(0XFFFFF8B7),
                        iccolor: Color(0XFFC4B000),
                        title: "Sejarah",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  overlayState.insert(overlayEntry);
}


