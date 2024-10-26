import 'package:alinea/controller/auth_controller.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/widgets/button/button_primary.dart';
import 'package:alinea/widgets/button/button_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  final box = GetStorage(); // Initialize GetStorage

  @override
  Widget build(BuildContext context) {
    // Check if the user is already logged in
    if (box.read('token') != null) {
      Future.delayed(Duration.zero, () {
        Get.offAllNamed(RouteName.homePage); // Replace with your home page route
      });
      return Container(); // Return an empty container while redirecting
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            // top: Get.height * 0.3,
            top: (MediaQuery.of(context).viewInsets.bottom > 0)
                ? Get.height * 0.1
                : Get.height * 0.3,
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
                    Obx(() => TextField(
                        controller: _usernameController,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "NIM atau Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          errorText: _authController.errors['username'],
                        ),
                      )
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Obx(() => TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          errorText: _authController.errors['password'],
                        ),
                      )
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        onPressed: () async {
                          await _authController.login(
                            username: _usernameController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                        },
                        child: Obx((){
                          return _authController.isLoading.value ? CircularProgressIndicator() : Text(
                              "Masuk",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                        }),
                      ),
                    ),

                    // Buttonprimary(
                    //   onTap: () {
                    //     _authController.login(
                    //       username: _usernameController.text.trim(),
                    //       password: _passwordController.text.trim(),
                    //     );
                    //   },
                    //   title: 'Masuk',
                    //   color: Colors.blue,
                    // ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
