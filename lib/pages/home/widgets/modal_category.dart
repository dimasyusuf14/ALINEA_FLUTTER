import 'package:alinea/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomModal(BuildContext context) {
  OverlayState overlayState = Overlay.of(context);
  final AuthController _authController = Get.put(AuthController());
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          overlayEntry.remove(); // Close modal when tapping outside
        },
        child: Stack(
          children: [
            Container(
              color: Colors.black54, // Semi-transparent background
            ),
            Positioned(
              top: Get.height * 0.15,
              left: Get.width * 0.7,
              right: Get.width * 0.06,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 150,
                  height: Get.height * 0.5,
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
                      // Other buttons here (like settings, etc.)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _authController.logout();
                            overlayEntry.remove();
                          },
                          icon: Icon(Icons.logout), // Logout icon
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

