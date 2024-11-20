import 'dart:convert';

import 'package:alinea/models/cart/cart_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  var isLoading = false.obs;
  var carts = <CartModel>[].obs;

  Future<void> fetchCarts() async {
    isLoading(true);
    try {
      final response = await APIServices.api(
        endPoint: APIEndpoint.carts,
        type: APIMethod.get,
        withToken: true,
      );

      if (response != null) {
        carts.assignAll(
          (response['data'] as List).map((e) {
            try {
              return CartModel.fromJson(e);
            } catch (e) {
              logPrint("Error parsing CartModel: $e");
              return null; // Filter out problematic entries
            }
          }).whereType<CartModel>().toList(),
        );
      } else {
        logPrint("Failed to load carts");
      }
    } catch (e) {
      logPrint("Fetch error: $e");
    } finally {
      isLoading(false);
    }
  }
}
