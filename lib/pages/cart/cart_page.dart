import 'package:alinea/controller/cart/cart_controller.dart';
import 'package:alinea/pages/cart/widget/floating_button.dart';
import 'package:alinea/pages/cart/widget/list_data_cart.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/appbar/appbar_default.dart';
import 'package:alinea/widgets/button/button_icon.dart';
import 'package:alinea/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alinea/model/cart/cart_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final CartController cartController = Get.put(CartController());
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarDefault(title: "Keranjang Saya"),
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              controller: refreshController,
              onRefresh: () async {
                await cartController.fetchCarts();
                refreshController.refreshCompleted();
              },
              child: SingleChildScrollView(
                child: Obx(
                  () {
                    if (cartController.isLoading.value) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartController.carts.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: CartItemTileShimmer(),
                            ),
                          );
                        },
                      );
                    } else if (cartController.carts.isEmpty) {
                      return const Center(child: Text('Keranjang kosong.'));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: cartController.carts.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartController.carts[index];
                          return CartItemTile(cartItem: cartItem);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Obx(
        () {
          final checkedItemsCount = cartController.selectedCarts.length;

          return FloatingButton(
            assetName: AssetConstant.icCheckout,
            title: "Check Out : ",
            jumlahData: '$checkedItemsCount',
            onPressed: () {
              if (checkedItemsCount > 0) {
                final selectedBooks = cartController.selectedCarts
                    .map((item) => {
                          'id': item.book.id,
                          'title': item.book.title,
                          'coverUrl': item.book.coverUrl,
                          'author': item.book.author,
                        })
                    .toList();

                Get.toNamed(
                  RouteName.checkOutPage,
                  arguments: selectedBooks,
                );
              } else {
                Get.snackbar(
                  "Perhatian",
                  "Pilih setidaknya 1 item untuk checkout!",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            color: kColorPrimary,
            titleColor: Colors.white,
          );
        },
      ),
    );
  }
}
