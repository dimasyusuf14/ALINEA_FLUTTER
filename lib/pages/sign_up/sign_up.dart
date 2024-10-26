// ignore_for_file: must_be_immutable

import 'package:alinea/controller/login/login_controller.dart';
import 'package:alinea/controller/signUp/sign_up_controller.dart';
import 'package:alinea/pages/home/home_page.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/widgets/button/button_primary.dart';
import 'package:alinea/widgets/button/button_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            // top: Get.height * 0.3,
            top: MediaQuery.of(context).viewInsets.bottom > 0
                ? Get.height * 0.1
                : Get.height * 0.2,
            child: Container(
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 60, bottom: 50),
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
                      onTap: () {
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
    );
  }
}
