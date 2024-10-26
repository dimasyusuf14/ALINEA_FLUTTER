import 'dart:convert';
import 'package:alinea/routes/route_name.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  final errors = <String, String>{}.obs;
  final token = ''.obs;
  final box = GetStorage();

  // Login function
  Future login({required String username, required String password}) async {
    try {
      isLoading.value = true;
      errors.clear();

      // Data to send to the API
      var data = {"username": username, "password": password};

      var response = await http.post(
        Uri.parse('https://alinea-api.my.id/api/login'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        final jsonResponse = json.decode(response.body);

        // Store the token in GetStorage
        token.value = jsonResponse['data']['token'] ?? '';
        box.write('token', token.value);

        // Redirect to the home page
        Get.offAllNamed(RouteName.mainPage);
      } else {
        isLoading.value = false;
        handleErrorResponse(response);
      }
    } catch (e) {
      isLoading.value = false;
      handleError(e);
    }
  }

  // Logout function
  void logout() {
    box.remove('token'); // Clear the token
    token.value = ''; // Clear the token variable
    Get.offAllNamed(RouteName.login); // Redirect to the login page
  }

  void handleErrorResponse(http.Response response) {
    if (response.statusCode == 422) {
      final jsonResponse = json.decode(response.body);
      jsonResponse['message'].forEach((key, value) {
        errors[key] = value[0];
      });
      debugPrint(errors.toString());
    } else {
      Get.snackbar(
        'Login Gagal!',
        json.decode(response.body)['message'],
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      debugPrint(json.decode(response.body).toString());
    }
  }

  void handleError(Object e) {
    Get.snackbar(
      'Error', 
      e.toString(),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    debugPrint(e.toString());
  }
}
