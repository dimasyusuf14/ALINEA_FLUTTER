import 'package:alinea/controller/profile/profile_controller.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/button/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showModalForm(BuildContext context, ProfileController controller) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0XFFC9D6F4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.pickImage();
                  },
                  child: Obx(
                    () {
                      return controller.selectedImage.value == null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[300],
                              child: Icon(Icons.camera_alt,
                                  color: Colors.grey[700]),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  FileImage(controller.selectedImage.value!),
                            );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nama Awal',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nama Akhir',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'NIM',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width * 0.35,
                      child: Buttonprimary(
                        title: "Simpan",
                        color: Colors.blue,
                        width: Get.width,
                        onPressed: () {
                          Get.toNamed(RouteName.profilePage);
                        },
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.35,
                      child: Buttonprimary(
                        title: "Batal",
                        color: Colors.red,
                        width: Get.width,
                        onPressed: () {
                          Get.back(); // Untuk menutup modal
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
