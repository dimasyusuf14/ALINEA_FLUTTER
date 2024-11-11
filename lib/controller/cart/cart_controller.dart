// ignore_for_file: avoid_print

import 'package:alinea/models/cart/cart_model.dart';
import 'package:alinea/models/home/home_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var loadingAddToCart = false.obs;
  var cartItems = <CartModel>[].obs;
  var checkC = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems(); // Optional: fetch initial cart items if required
  }

  // Method to add a book to the cart
  Future<void> addToCart(int userId, int bookId) async {
    loadingAddToCart.value = true;
    try {
      var response = await APIServices.api(
        endPoint: APIEndpoint.addcart,
        type: APIMethod.post,
        withToken: true,
      );

      if (response != null && response['id'] != null) {
        CartModel cartItem = CartModel.fromJson(response);
        cartItems.add(cartItem); // Update cart item list with the new item
        Get.snackbar(
          'Success',
          'Book added to cart successfully!',
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to add book to cart.',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print("Error adding to cart: $e");
      Get.snackbar(
        'Error',
        'An error occurred while adding the book to the cart.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      loadingAddToCart.value = false;
    }
  }

  // Optional: Method to fetch current cart items from the API
  void fetchCartItems() async {
    try {
      var response = await APIServices.api(
        endPoint: APIEndpoint.cart,
        type: APIMethod.get,
        withToken: true,
      );

      if (response['data'] != null) {
        var dataList = response['data'] as List;
        cartItems.value = dataList.map((e) => CartModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("Error fetching cart items: $e");
    }
  }
}
