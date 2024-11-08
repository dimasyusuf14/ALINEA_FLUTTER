import 'package:alinea/controller/home/book_controller.dart';
import 'package:alinea/controller/home/categories_controller.dart'; // Ensure this is imported
import 'package:alinea/models/home/home_model.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/widgets/button/button_icon.dart';
import 'package:alinea/widgets/button/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final BookController bookController = Get.put(BookController());
  final CategoriesController categoryController =
      Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> book = Get.arguments as Map<String, dynamic>;

    final String categoryIdString =
        book['category_id'] ?? '0'; // Tetap sebagai String
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
              Positioned(
                top: Get.height * 0.13,
                left: Get.width * 0.25,
                right: Get.width * 0.25,
                child: Container(
                  height: 291,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.amber,
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
              decoration: const BoxDecoration(
                color: Color(0XFFF1F4FD),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  right: 20,
                  left: 20,
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
                                SizedBox(
                                  width: Get.width * 0.65,
                                  child: Text(
                                    book['title'] ?? 'Title Not Available',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  // width: 60,
                                  decoration: BoxDecoration(
                                    color: Color(0XFFC9CCF4),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      category.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0XFF445DCC),
                                        fontWeight: FontWeight.w500,
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
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  DateFormat.yMMMd()
                                      .format(book["published_date"]),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              "Sinopsis",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            // const SizedBox(height: 10),
                            HtmlWidget(
                              book['description'] ??
                                  'Description not available.',
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
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
                            onPressed: () {
                              Get.toNamed(RouteName.mainPage);
                            },
                            title: 'Pinjam Sekarang',
                            color: Colors.blue,
                            width: 285,
                          ),
                          ButtonIcon(
                            onTap: () {
                              Get.toNamed(RouteName.login);
                            },
                            icon: AssetConstant.icAddChart,
                            bgcolor: Colors.blue,
                            iccolor: Colors.white,
                          ),
                        ],
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
