// ignore_for_file: must_be_immutable

import 'package:alinea/controller/auth/login/login_controller.dart';
import 'package:alinea/controller/auth/signUp/sign_up_controller.dart';
import 'package:alinea/pages/home/home_page.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/widgets/button/button_primary.dart';
import 'package:alinea/widgets/button/button_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  SignUpController controller = Get.put(SignUpController());

  final box = GetStorage(); // Initialize GetStorage

  @override
  Widget build(BuildContext context) {
    // Check if the user is already logged in
    if (box.read('token') != null) {
      Future.delayed(Duration.zero, () {
        Get.offAllNamed(
            RouteName.homePage); // Replace with your home page route
      });
      return Container(); // Return an empty container while redirecting
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Image.asset(
                AssetConstant.logo,
                width: 180,
                height: 180,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 30),
                  decoration: BoxDecoration(
                    color: Color(0XFFF1F4FD),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "DAFTAR",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Text.rich(
                          TextSpan(
                            children: const [
                              TextSpan(
                                text: "Daftar sekarang di ",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text: "ALINEA ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                  text:
                                      "untuk melihat berbagai genre buku yang menarik."),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //text inpuT email
                        TextField(
                          autocorrect: false,
                          controller: controller.emailController.value,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        //text input nim
                        TextField(
                          autocorrect: false,
                          controller: controller.emailController.value,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "NIM",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        //text input pw
                        Obx(
                          () => TextField(
                            autocorrect: false,
                            controller: controller.passController.value,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: controller.isHidden.value,
                            decoration: InputDecoration(
                              labelText: "Password",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.isHidden.value =
                                      !controller.isHidden.value;
                                },
                                icon: Icon(controller.isHidden.isFalse
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        //text input konfirmasi   pw
                        Obx(
                          () => TextField(
                            autocorrect: false,
                            controller: controller.passController.value,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: controller.isHidden.value,
                            decoration: InputDecoration(
                              labelText: "Konfirmasi Password",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.isHidden.value =
                                      !controller.isHidden.value;
                                },
                                icon: Icon(controller.isHidden.isFalse
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        // daftar Button
                        Buttonprimary(
                          fontSize: 18,
                          onPressed: () {
                            Get.toNamed(RouteName.login);
                          },
                          title: 'Daftar',
                          color: Colors.blue,
                          width: 345,
                        ),

                        SizedBox(height: 20),
                        // Register Text
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sudah punya akun? ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            Buttontext(
                              onTap: () {
                                Get.toNamed(RouteName.login);
                              },
                              title: "Masuk",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
