import 'dart:io';

import 'package:alinea/model/profile/profile_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'
    as html_widget;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart' as picker;

class ProfileController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
  var isLoading = false.obs;
  var nameController = TextEditingController().obs;
  var nimController = TextEditingController().obs;
  var imageController = TextEditingController().obs;
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;

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

      if (response['data'] != null) {
        userProfile.value = UserModel.fromJson(response['data']);
        loadingProfile.value = DataLoad.done;
      } else {
        loadingProfile.value = DataLoad.failed;
      }
    } catch (e) {
      loadingProfile.value = DataLoad.failed;
      print("Error fetching profile: $e");
    }
  }

  Future<void> pickImage() async {
    var pickerInstance = picker.ImagePicker();
    var pickedFile =
        await pickerInstance.pickImage(source: picker.ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void resetForm() {
    nameController.value.clear(); // Reset judul
    nimController.value.clear(); // Reset artikel
    selectedImage.value = null; // Reset gambar
  }

  bool _validateForm() {
    if (selectedImage.value == null || // Validasi agar gambar tidak null
        nameController.value.text.isEmpty ||
        nimController.value.text.isEmpty) {
      Get.snackbar('Error', 'Semua field harus diisi');
      return false;
    }
    return true;
  }

  void clearForm() {
    selectedImage.value = null;
    nameController.value.clear(); // Reset judul
    nimController.value.clear();
  }
}
