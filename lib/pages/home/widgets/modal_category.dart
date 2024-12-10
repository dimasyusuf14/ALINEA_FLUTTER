import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alinea/controller/home/book_controller.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/widgets/button/button_category.dart';

void showCustomModal(BuildContext context, BookController controller) {
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
              right: Get.width * 0.04,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 150,
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
                          controller.filterBooksByCategory(0);
                          overlayEntry.remove();
                        },
                        icon: AssetConstant.icAll,
                        bgcolor: Color(0XFFC9D6F4),
                        iccolor: Color(0XFF445DCC),
                        title: "All",
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      ButtonCategory(
                        onTap: () {
                          controller.filterBooksByCategory(1);
                          overlayEntry.remove();
                        },
                        icon: AssetConstant.icAksi,
                        bgcolor: Color(0XFFFFDADA),
                        iccolor: Color(0XFFFF0000),
                        title: "Aksi",
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      ButtonCategory(
                        onTap: () {
                          controller.filterBooksByCategory(2);
                          overlayEntry.remove();
                        },
                        icon: AssetConstant.icFiksi,
                        bgcolor: Color(0XFFC3FFD4),
                        iccolor: Color(0XFF009F2C),
                        title: "Fiksi",
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      ButtonCategory(
                        onTap: () {
                          controller.filterBooksByCategory(3);
                          overlayEntry.remove();
                        },
                        icon: AssetConstant.icRomance,
                        bgcolor: Color(0XFFFFE0F6),
                        iccolor: Color(0XFFFF00B8),
                        title: "Romansa",
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ButtonCategory(
                        onTap: () {
                          controller.filterBooksByCategory(4);
                          overlayEntry.remove();
                        },
                        icon: AssetConstant.icHoror,
                        bgcolor: Color(0XFFCFE5FF),
                        iccolor: Color(0XFF0075FF),
                        title: "Horor",
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      ButtonCategory(
                        onTap: () {
                          controller.filterBooksByCategory(5);
                          overlayEntry.remove();
                        },
                        icon: AssetConstant.icSejarah,
                        bgcolor: Color(0XFFFFF8B7),
                        iccolor: Color(0XFFC4B000),
                        title: "Sejarah",
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      ButtonCategory(
                        onTap: () {
                          controller.filterBooksByCategory(16);
                          overlayEntry.remove();
                        },
                        icon: AssetConstant.icPendidikan,
                        bgcolor: Color(0XFFfed6ca),
                        iccolor: Color(0XFFed6b46),
                        title: "Pendidikan",
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
