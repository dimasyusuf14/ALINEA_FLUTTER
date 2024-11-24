import 'dart:convert';

import 'package:alinea/model/cart/cart_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  var isLoading = false.obs;
  var carts = <CartModel>[].obs;
  var isChecked = false.obs;

// Periksa apakah buku sudah ada di keranjang
  bool isBookInCart(int bookId) {
    return carts.any((cart) => cart.book.id == bookId);
  }

  Future<void> fetchCarts() async {
    isLoading(true);
    try {
      final response = await APIServices.api(
        endPoint: APIEndpoint.carts,
        type: APIMethod.get,
        withToken: true,
      );

      if (response != null) {
        final fetchedCarts = (response['data'] as List)
            .map((e) {
              try {
                return CartModel.fromJson(e);
              } catch (e) {
                logPrint("Error parsing CartModel: $e");
                return null;
              }
            })
            .whereType<CartModel>()
            .toList();

        // Hapus data lama dan tambahkan yang baru
        carts.clear();
        carts.addAll(fetchedCarts);

        // Urutkan keranjang berdasarkan waktu penambahan terbaru
        carts.sort((a, b) => b.createdAt
            .compareTo(a.createdAt)); // createdAt adalah waktu penambahan
      } else {
        logPrint("Failed to load carts");
      }
    } catch (e) {
      logPrint("Fetch error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> addToCart(int bookId) async {
    try {
      final response = await APIServices.api(
        endPoint:
            APIEndpoint.addcart.replaceFirst("{bookId}", bookId.toString()),
        type: APIMethod.post,
        withToken: true,
      );

      if (response != null && response['status'] == true) {
        final newCart = CartModel.fromJson(response['data']);
        final existingIndex =
            carts.indexWhere((cart) => cart.bookId == newCart.bookId);

        if (existingIndex == -1) {
          // Tambahkan item ke awal daftar
          carts.insert(0, newCart);

          // Beri notifikasi keberhasilan
          Get.snackbar(
            "Berhasil",
            "Buku berhasil ditambahkan ke keranjang.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.greenAccent,
            colorText: Colors.white,
          );
        }
      } else {
        // Gagal menambahkan buku ke keranjang
        Get.snackbar(
          "Halo!",
          "Buku yang kamu pilih sudah ada di keranjang.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Tangani error
      logPrint("Add to cart error: $e");
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat menambahkan buku ke keranjang.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  Future<void> deleteCart(int cartId) async {
    try {
      final response = await APIServices.api(
        endPoint:
            APIEndpoint.deleteCart.replaceFirst("{cartId}", cartId.toString()),
        type: APIMethod.delete,
        withToken: true,
      );

      if (response != null && response['status'] == true) {
        carts.removeWhere((cart) => cart.id == cartId);
        logPrint("Cart deleted: $cartId");
        logPrint("Remaining carts: ${carts.length}");
        carts.refresh();
        fetchCarts();
      } else {
        // Beri notifikasi kegagalan
        Get.snackbar(
          "Gagal",
          "Gagal menghapus buku dari keranjang.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Tangani error
      logPrint("Delete error: $e");
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat menghapus buku dari keranjang.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
