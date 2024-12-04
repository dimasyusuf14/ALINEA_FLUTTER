import 'package:alinea/controller/auth/login/login_controller.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/button/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
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
                height: 40,
              ),
              Image.asset(
                AssetConstant.logo,
                width: 200,
                height: 200,
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 50),
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
                          "MASUK",
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
                                text:
                                    "Silahkan masuk untuk mengakses koleksi buku di ",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text: "ALINEA",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //text input nim atau email
                        TextField(
                          autocorrect: false,
                          controller: controller.emailController.value,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "NIM dan Email",
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
                        // Remember Me and Forgot Password Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Obx(
                                  () => Checkbox(
                                    value: controller.checkC.value,
                                    onChanged: (value) =>
                                        controller.checkC.toggle(),
                                    activeColor: Color(0XFF445DCC),
                                  ),
                                ),
                                Text(
                                  "Remember Me?",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Login Button

                        Buttonprimary(
                          fontSize: 18,
                          title: 'Masuk',
                          color: kColorPrimary,
                          onPressed: () {
                            controller.login();
                          },
                          width: 345,
                        ),

                        SizedBox(height: 20),
                        // Register Text
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Belum punya akun? ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(RouteName.signUp);
                              },
                              child: Text(
                                "Daftar",
                                style: TextStyle(
                                  color: Color(0XFF445DCC),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
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
