import 'package:alinea/controller/home/categories_controller.dart';
import 'package:alinea/models/home/home_model.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:alinea/controller/home/book_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

class CarouselBook extends StatelessWidget {
  final BookController bookController = Get.find<BookController>();
  final CategoriesController categoryController =
      Get.put(CategoriesController());

  CarouselBook({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Obx(() {
        if (bookController.loadingFetchBook.value == DataLoad.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (bookController.loadingFetchBook.value == DataLoad.failed) {
          return Center(
            child: Text(
              "Failed to load data",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          );
        } else if (bookController.listBook.isEmpty) {
          return Center(
            child: Text(
              "No data available",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return CarouselSlider(
            options: CarouselOptions(
              height: 150,
              aspectRatio: 0.95,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
            ),
            items: List.generate(bookController.listBook.length, (index) {
              final book = bookController.listBook[index];
              final category = categoryController.listCategory.firstWhere(
                (cat) => cat.id == int.tryParse(book.categoryId),
                orElse: () => Category(
                  id: 0,
                  name: "Unknown",
                  description: "",
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              );

              return Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(
                        RouteName.detailPage,
                        arguments: {
                          'title': book.title,
                          'author': book.author,
                          'description': book.description,
                          'coverUrl': book.coverUrl,
                          'category_id': book.categoryId,
                          'published_date': book.publishedDate,
                          'stock': book.stock,
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(9),
                              child: Image.network(
                                book.coverUrl,
                                fit: BoxFit.cover,
                                width: 95,
                                height: Get.height * 0.18,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    book.author,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    DateFormat.yMMMd()
                                        .format(book.publishedDate),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    height: 30,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }
      }),
    );
  }
}
