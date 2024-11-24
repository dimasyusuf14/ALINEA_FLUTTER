import 'package:alinea/controller/cart/cart_controller.dart';
import 'package:alinea/pages/cart/widget/floating_button.dart';
import 'package:alinea/pages/cart/widget/list_data_cart.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/appbar/appbar_default.dart';
import 'package:alinea/widgets/button/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alinea/models/cart/cart_model.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    cartController.fetchCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await cartController.fetchCarts();
        },
        child: Column(
          children: [
            AppBarDefault(title: "Keranjang Saya"),
            Expanded(
              child: Obx(() {
                if (cartController.isLoading.value) {
                  // Menampilkan shimmer effect ketika data masih loading
                  return ListView.builder(
                    itemCount: 5, // Jumlah shimmer item yang ingin ditampilkan
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child:
                              CartItemTileShimmer(), // Menggunakan shimmer untuk item cart
                        ),
                      );
                    },
                  );
                } else if (cartController.carts.isEmpty) {
                  return const Center(child: Text('Keranjang kosong.'));
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.zero, // Menghapus celah di atas
                    itemCount: cartController.carts.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartController.carts[index];
                      return CartItemTile(cartItem: cartItem);
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() {
        final checkedItemsCount = cartController.carts
            .where((cartItem) => cartItem.isChecked.value)
            .length;

        final displayCount = checkedItemsCount > 3 ? 3 : checkedItemsCount;

        return FloatingButton(
          assetName: AssetConstant.icCheckout,
          title: "Check Out : ",
          jumlahData: '$displayCount',
          onPressed: () {
            if (checkedItemsCount > 0) {
              // Arahkan ke halaman checkout
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
      }),
    );
  }
}

// Widget Shimmer untuk item cart
class CartItemTileShimmer extends StatelessWidget {
  const CartItemTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Container(
          width: 20,
          height: 20,
          color: Colors.grey.shade300,
        ),
        const SizedBox(width: 10),
        // Shimmer untuk gambar thumbnail
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 110,
            height: 160,
            color: Colors.grey.shade300,
          ),
        ),
        const SizedBox(width: 10),
        // Shimmer untuk teks title dan author
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 10),
              Container(
                width: 150,
                height: 15,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 10),
              Container(
                width: 100,
                height: 15,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 10),
              // Shimmer untuk kategori
              Container(
                width: 80,
                height: 20,
                color: Colors.grey.shade300,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
