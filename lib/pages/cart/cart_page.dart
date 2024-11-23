import 'package:alinea/controller/cart/cart_controller.dart';
import 'package:alinea/pages/cart/widget/floating_button.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/button/button_icon.dart';
import 'package:alinea/widgets/button/button_list_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alinea/models/cart/cart_model.dart';

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
      appBar: AppBar(
        title: const Text('Keranjang Saya'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await cartController
              .fetchCarts(); // Memanggil kembali data dari server
        },
        child: Obx(() {
          if (cartController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (cartController.carts.isEmpty) {
            return const Center(child: Text('Keranjang kosong.'));
          } else {
            return Obx(
              () => ListView.builder(
                itemCount: cartController.carts.length,
                itemBuilder: (context, index) {
                  final cartItem = cartController.carts[index];
                  return CartItemTile(cartItem: cartItem);
                },
              ),
            );
          }
        }),
      ),
      floatingActionButton: FloatingButton(
        assetName: AssetConstant.icCheckout,
        title: "Check Out",
        onPressed: () {},
        color: kColorPrimary,
        titleColor: Colors.white,
      ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  final CartModel cartItem;
  final CartController cartController = Get.find<CartController>();
  CartItemTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.23,
      width: Get.width,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0XFFE0E8F9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(
            () => Checkbox(
              value: cartItem.isChecked.value,
              onChanged: (value) {
                cartItem.isChecked.value = value ?? false;
              },
              activeColor: Colors.blue,
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(
                RouteName.detailPage,
                arguments: {
                  'title': cartItem.book.title,
                  'author': cartItem.book.author,
                  'description': cartItem.book.description,
                  'coverUrl': cartItem.book.coverUrl,
                  'category_id': cartItem.book.categoryId,
                  'published_date': cartItem.book.publishedDate,
                  'stock': cartItem.book.stock,
                },
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                cartItem.book.coverUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 50);
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: () {
              Get.toNamed(
                RouteName.detailPage,
                arguments: {
                  'title': cartItem.book.title,
                  'author': cartItem.book.author,
                  'description': cartItem.book.description,
                  'coverUrl': cartItem.book.coverUrl,
                  'category_id': cartItem.book.categoryId,
                  'published_date': cartItem.book.publishedDate,
                  'stock': cartItem.book.stock,
                },
              );
            },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.book.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      cartItem.book.author,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.width * 0.25,
                          height: 30,
                          margin: EdgeInsets.only(right: 75),
                          decoration: BoxDecoration(
                            color: Color(0xFFC9CCF4),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              cartItem.category?.name ??
                                  'Kategori tidak tersedia',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: kColorPrimary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: ButtonIcon(
                            onTap: () {
                              cartController.deleteCart(cartItem.id);
                            },
                            icon: AssetConstant.icDelete,
                            bgcolor: Colors.transparent,
                            iccolor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Stock: ${cartItem.book.stock}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
