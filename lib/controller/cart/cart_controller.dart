import 'package:alinea/models/cart/cart_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum DataLoad { loading, done, failed }

class CartController extends GetxController {
  var loadingAddToCart = false.obs;
  var cartItems = <CartModel>[].obs;
  var checkC = false.obs;
  var loadingFetchCart = DataLoad.done.obs;
  var fetchedCartItems = <CartModel>[].obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  // Fetch current cart items from the API based on userId
  void fetchCartItems() async {
    int? id = storage.read('id'); // Read userId from storage
    print("id: $id");
    if (id == null) {
      loadingFetchCart.value = DataLoad.failed;
      return;
    }

    loadingFetchCart.value = DataLoad.loading;
    try {
      var response = await APIServices.api(
        endPoint: APIEndpoint.carts,
        type: APIMethod.get,
        withToken: true,
      );

      if (response != null && response['data'] != null) {
        var dataList = response['data'] as List;
        List<CartModel> fetchedCartItems =
            dataList.map((e) => CartModel.fromJson(e)).toList();

        fetchedCartItems.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        cartItems.value = fetchedCartItems;
        loadingFetchCart.value = DataLoad.done;
      } else {
        loadingFetchCart.value = DataLoad.failed;
      }
    } catch (e) {
      loadingFetchCart.value = DataLoad.failed;
    }
  }

  void deleteCartItem(int itemId) {
    cartItems.removeWhere((item) => item.id == itemId);
  }
}
