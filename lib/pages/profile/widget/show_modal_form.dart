import 'package:alinea/controller/profile/profile_controller.dart';
import 'package:alinea/widgets/button/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showModalForm(BuildContext context, ProfileController controller) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0XFFC9D6F4),
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
                const SizedBox(height: 16.0),
                TextFormField(
                  autocorrect: false,
                  controller: controller.firstNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Nama Awal",
                    labelStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  autocorrect: false,
                  controller: controller.lastNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Nama Akhir",
                    labelStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  autocorrect: false,
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  autocorrect: false,
                  controller: controller.confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width * 0.35,
                      child: Buttonprimary(
                        fontSize: 18,
                        title: "Simpan",
                        color: Colors.blue,
                        width: Get.width,
                        onPressed: () {
                          controller.updateProfile();
                          Get.back(); // Close modal after update
                        },
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.35,
                      child: Buttonprimary(
                        fontSize: 18,
                        title: "Batal",
                        color: Colors.red,
                        width: Get.width,
                        onPressed: () {
                          Get.back(); // Close modal
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
