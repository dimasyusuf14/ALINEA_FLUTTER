// ignore_for_file: must_be_immutable

import 'package:alinea/controller/auth/login/login_controller.dart';
import 'package:alinea/controller/auth/signUp/sign_up_controller.dart';
import 'package:alinea/pages/home/home_page.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/button/button_primary.dart';
import 'package:alinea/widgets/button/button_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  SignUpController controller = Get.put(SignUpController());

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    if (box.read('token') != null) {
      Future.delayed(Duration.zero, () {
        Get.offAllNamed(RouteName.login);
      });
      return Container();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 70),
                          child: Row(
                            children: [
                              Image.asset(
                                AssetConstant.logo,
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "DAFTAR",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ],
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
                        TextField(
                          autocorrect: false,
                          controller: controller.firstNameController.value,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Nama Awal",
                            labelStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          autocorrect: false,
                          controller: controller.lastNameController.value,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Nama Akhir",
                            labelStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          autocorrect: false,
                          controller: controller.emailController.value,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          autocorrect: false,
                          controller: controller.nimController.value,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "NIM",
                            labelStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => TextField(
                            autocorrect: false,
                            controller: controller.passController.value,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: controller.isHidden.value,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(fontSize: 14),
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
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Obx(
                          () => TextField(
                            autocorrect: false,
                            controller: controller.confirmPassController.value,
                            keyboardType: TextInputType.visiblePassword,
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
                        Buttonprimary(
                          fontSize: 18,
                          onPressed: () {
                            controller.signUp();
                          },
                          title: 'Daftar',
                          color: kColorPrimary,
                          width: 345,
                        ),
                        SizedBox(height: 20),
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
