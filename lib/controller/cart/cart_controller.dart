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
  var selectedCarts = <CartModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCarts();
  }

  List<CartModel> get selectedItems =>
      carts.where((cart) => cart.isChecked.value).toList();
  bool isBookInCart(int bookId) {
    return carts.any((cart) => cart.book.id == bookId);
  }

  void toggleCartSelection(CartModel cartItem, bool isSelected) {
    cartItem.isChecked.value = isSelected;
    if (isSelected) {
      selectedCarts.add(cartItem);
    } else {
      selectedCarts.removeWhere((item) => item.id == cartItem.id);
    }
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

        selectedCarts.clear();
        carts.clear();
        carts.addAll(fetchedCarts);
        carts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
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
          carts.insert(0, newCart);
          Get.snackbar(
            "Berhasil",
            "Buku berhasil ditambahkan ke keranjang.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.greenAccent,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Halo!",
          "Buku yang kamu pilih sudah ada di keranjang.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
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
        carts.removeWhere((cart) =>
            selectedCarts.any((selectedItem) => selectedItem.id == cart.id));
        logPrint("Cart deleted: $cartId");
        logPrint("Remaining carts: ${carts.length}");
        carts.refresh();
        fetchCarts();
      } else {
        Get.snackbar(
          "Gagal",
          "Gagal menghapus buku dari keranjang.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
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

  void removeCheckedItems() async {
    for (var cartItem in selectedCarts) {
      try {
        final response = await APIServices.api(
          endPoint: APIEndpoint.deleteCart
              .replaceFirst("{cartId}", cartItem.id.toString()),
          type: APIMethod.delete,
          withToken: true,
        );

        if (response != null && response['status'] == true) {
          carts.removeWhere((cartItem) => selectedCarts
              .any((selectedItem) => selectedItem.id == cartItem.id));
          selectedCarts.clear();
          carts.refresh();
          logPrint(
              "Cart item deleted from server and local list: ${cartItem.id}");
        } else {
          Get.snackbar(
            "Gagal",
            "Gagal menghapus buku dari keranjang.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        logPrint("Error while removing cart item: $e");
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
}
