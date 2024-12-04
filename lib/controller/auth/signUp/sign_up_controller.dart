import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignUpController extends GetxController {
  var emailController = TextEditingController().obs;
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var nimController = TextEditingController().obs;
  var passController = TextEditingController().obs;
  var confirmPassController = TextEditingController().obs;

  var isHidden = false.obs;

  void signUp() async {
    if (passController.value.text != confirmPassController.value.text) {
      Helper.setSnackbar('Password and confirmation password do not match.');
      return;
    }

    Helper.loadingScreen();

    var requestBodyMap = {
      "first_name": firstNameController.value.text,
      "last_name": lastNameController.value.text,
      "email": emailController.value.text,
      "nim": nimController.value.text,
      "password": passController.value.text,
      "password_confirmation": confirmPassController.value.text,
    };

    try {
      var data = await APIServices.api(
          endPoint: APIEndpoint.register,
          type: APIMethod.post,
          requestBodyMap: requestBodyMap,
          withToken: false);

      if (data['status'] == true) {
        Get.back();
        var token = data['data']['access_token'];
        final box = GetStorage();
        await box.write("token", token);

        // Tampilkan snackbar berhasil
        Get.snackbar(
          'Registrasi Berhasil',
          'Selamat, akun Anda telah berhasil dibuat.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );

        Get.offAllNamed(RouteName.login);
      } else {
        Get.back();
        Helper.setSnackbar('Error: ${data['message']}');
      }
    } catch (e) {
      Get.back();
      Helper.setSnackbar('An error occurred: ${e.toString()}');
      logPrint("ERR : ${e.toString()}");
    }
  }
}
