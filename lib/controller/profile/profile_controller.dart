import 'dart:convert';
import 'dart:io';

import 'package:alinea/model/profile/profile_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ProfileController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
  var isLoading = false.obs;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var imageProfileController = ''.obs;

  var loadingProfile = DataLoad.loading.obs;
  var userProfile = UserModel(
    id: 0,
    image: null,
    nim: '',
    email: '',
    firstName: '',
    lastName: '',
    status: '',
    dueBlock: null,
    role: '',
    noInvoice: null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    imageUrl: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    loadingProfile.value = DataLoad.loading;
    try {
      var response = await APIServices.api(
        endPoint: APIEndpoint.me,
        type: APIMethod.get,
        withToken: true,
      );

      if (response != null && response['data'] != null) {
        userProfile.value = UserModel.fromJson(response['data']);
        imageProfileController.value = userProfile.value.imageUrl;
        firstNameController.text = userProfile.value.firstName;
        lastNameController.text = userProfile.value.lastName;
        emailController.text = userProfile.value.email;
        loadingProfile.value = DataLoad.done;
      } else {
        loadingProfile.value = DataLoad.failed;
      }
    } catch (e) {
      loadingProfile.value = DataLoad.failed;
      print("Error fetching profile: $e");
    }
  }

  void updateProfile() async {
    if (!_validateUpdateForm()) return;

    isLoading.value = true;
    try {
      var requestBody = {
        'image_url': imageProfileController.value,
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        if (passwordController.text.isNotEmpty)
          'password': passwordController.text,
        if (passwordController.text.isNotEmpty)
          'password_confirmation': confirmPasswordController.text,
      };

      var response;
      if (selectedImage.value != null) {
        response = await APIServices.api(
          endPoint: APIEndpoint.updateProfile,
          type: APIMethod.post,
          withToken: true,
          requestBodyMap: requestBody,
          file: selectedImage.value,
        );
      } else {
        response = await APIServices.api(
          endPoint: APIEndpoint.updateProfile,
          type: APIMethod.post,
          withToken: true,
          requestBodyMap: requestBody,
        );
      }

      if (response != null && response['success'] == true) {
        Get.snackbar('Success', 'Profile updated successfully!');
        fetchUserProfile();
      } else if (response?['message'] != null) {
        Get.snackbar('Error', response['message']);
      } else {
        Get.snackbar('Error', 'Failed to update profile. Please try again.');
      }
    } catch (e) {
      print("Error updating profile: $e");
      Get.snackbar('Error', 'An error occurred while updating profile.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    var pickerInstance = ImagePicker();
    var pickedFile =
        await pickerInstance.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  bool _validateUpdateForm() {
    if (firstNameController.text.isEmpty || lastNameController.text.isEmpty) {
      Get.snackbar('Error', 'First name and last name cannot be empty.');
      return false;
    }
    if (passwordController.text.isNotEmpty &&
        passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match.');
      return false;
    }
    return true;
  }
}
