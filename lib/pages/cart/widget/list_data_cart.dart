import 'package:alinea/controller/cart/cart_controller.dart';
import 'package:alinea/model/cart/cart_model.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/button/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemTile extends StatelessWidget {
  final CartModel cartItem;
  final CartController cartController = Get.find<CartController>();
  CartItemTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.23,
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 8),
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
                final checkedItemsCount = cartController.carts
                    .where((cartItem) => cartItem.isChecked.value)
                    .length;

                if (value == true && checkedItemsCount >= 3) {
                  Get.snackbar(
                    "Batas Maksimal",
                    "Anda sudah mencapai jumlah maksimal peminjaman.",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                } else {
                  cartItem.isChecked.value = value ?? false;
                }
              },
              activeColor: kColorPrimary,
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