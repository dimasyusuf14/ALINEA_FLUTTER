// ignore_for_file: prefer_const_declarations

import 'package:alinea/controller/cart/cart_controller.dart';
import 'package:alinea/controller/home/book_controller.dart';
import 'package:alinea/controller/home/categories_controller.dart'; // Ensure this is imported
import 'package:alinea/model/home/home_model.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/appbar/appbar_secondary.dart';
import 'package:alinea/widgets/button/button_icon.dart';
import 'package:alinea/widgets/button/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final BookController bookController = Get.put(BookController());
  final CategoriesController categoryController =
      Get.put(CategoriesController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> book = Get.arguments as Map<String, dynamic>;
    final int? bookId = book['id'];
    final String categoryIdString = book['category_id']?.toString() ?? '0';

    final category = categoryController.listCategory.firstWhere(
      (cat) => cat.id.toString() == categoryIdString,
      orElse: () => Category(
        id: 0,
        name: "Unknown",
        description: "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0XFFE0E8F9),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: Get.width * 0.65,
                width: Get.width,
                decoration: BoxDecoration(
                  color: const Color(0XFF445DCC),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              AppBarSecondary(
                title: "Detail Page",
              ),
              Positioned(
                top: Get.height * 0.13,
                left: Get.width * 0.25,
                right: Get.width * 0.25,
                child: Container(
                  height: 291,
                  width: 200,
                  decoration: BoxDecoration(
                    color: kColorPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      book['coverUrl'] ?? '', // Handle null cases
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 160),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
              ),
              decoration: const BoxDecoration(
                color: Color(0XFFF1F4FD),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 280,
                    width: Get.width,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  book['title'] ?? 'Title Not Available',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0XFFC9CCF4),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    category.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0XFF445DCC),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                book['author'] ?? 'Author Unknown',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                DateFormat.yMMMd()
                                    .format(book["published_date"]),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Text(
                            'Stock: ${book['stock'] ?? 'Not Available'}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "Sinopsis",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          HtmlWidget(
                            '<div style="text-align: justify;">${book['description'] ?? 'Description not available.'}</div>',
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 45,
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      
                        Buttonprimary(
                          fontSize: 18,
                          onPressed: () {
                            // Ensure the book data is passed to CheckOutPage
                            final selectedBook = {
                              'id': book['id'],
                              'title': book['title'],
                              'coverUrl': book['coverUrl'],
                              'author': book['author'],
                              'category_id': book['category_id'],
                              'published_date': book['published_date'],
                              'stock': book['stock'],
                              'description': book['description'],
                            };

                            Get.toNamed(
                              RouteName.checkOutPage,
                              arguments: [
                                selectedBook
                              ], // Pass the book data as arguments
                            );
                          },
                          title: 'Pinjam Sekarang',
                          color: kColorPrimary,
                          width: 285,
                        ),

                        ButtonIcon(
                          onTap: () {
                            if (bookId != null) {
                              cartController.addToCart(bookId);
                            } else {
                              Get.snackbar(
                                "Cek Keranjang",
                                "Buku yang kamu pilih sudah ada di keranjang.",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.redAccent,
                                colorText: Colors.white,
                              );
                            }
                          },
                          icon: AssetConstant.icAddChart,
                          bgcolor: kColorPrimary,
                          iccolor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
