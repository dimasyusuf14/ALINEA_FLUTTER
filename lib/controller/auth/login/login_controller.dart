import 'package:alinea/models/login/user_model.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

        // Ambil dan simpan token, role, dan userId ke GetStorage
        var token = data['data']['access_token'];
        var role = data['data']['role'];
        var id = data['data']['id']; // Ambil userId dari respons

        final box = GetStorage();
        await box.write("token", token);
        await box.write("role", role);
        await box.write("id", id); // Simpan userId ke GetStorage

        

        Get.offAllNamed(RouteName.mainPage);
      } else {
        Get.back();
        Helper.setSnackbar(
            'Login gagal, periksa kembali username dan password.');
      }
    } catch (e) {
      Get.back();
      Helper.setSnackbar('Terjadi kesalahan saat login. Silakan coba lagi.');
      logPrint("ERR : ${e.toString()}");
    }
  }

  void logout() async {
    final box = GetStorage();
    await box.remove("token"); // Hapus token yang disimpan
    await box.remove("id"); // Hapus userId yang disimpan
    Get.toNamed(RouteName.login); // Navigasi ke halaman login
  }

  void signUp() {
    // Implementasikan logika untuk registrasi di sini
  }
}
