import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomModal(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry; // Use 'late' to delay initialization

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
                    height: Get.height*0.5,
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
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.access_alarm),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.access_alarm),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.access_alarm),
                          ),
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
