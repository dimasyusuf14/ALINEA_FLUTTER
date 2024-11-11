import 'package:alinea/models/login/user_model.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var passController = TextEditingController(text: "password").obs;
  var usernameController = TextEditingController(text: "user@example.com").obs;
  var checkC = false.obs;
  var isHidden = false.obs;

  void login() async {
    Helper.loadingScreen();

    var requestBodyMap = {
      "username": usernameController.value.text,
      "password": passController.value.text,
    };

    try {
      var data = await APIServices.api(
          endPoint: APIEndpoint.login,
          type: APIMethod.post,
          requestBodyMap: requestBodyMap);

      if (data['status'] == true) {
        Get.back();
        var token = data['data']['access_token'];
        final box = GetStorage();
        await box.write("token", token);
        Get.offAllNamed(RouteName.mainPage);
      } else {
        Get.back();
        Helper.setSnackbar('eror');
      }
    } catch (e) {
      Get.back();
      Helper.setSnackbar(e.toString());
      logPrint("ERR : ${e.toString()}");
    }
  }

  void logout() async {
    final box = GetStorage();
    await box.remove("token"); // Remove the stored token
    Get.toNamed(RouteName.login); // Navigate to the login page
  }

  void signUp() {}


}
