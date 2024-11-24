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
import 'package:shimmer/shimmer.dart'; // Import shimmer package


class CarouselBook extends StatelessWidget {
  final BookController bookController = Get.find<BookController>();
  final CategoriesController categoryController =
      Get.put(CategoriesController());

  CarouselBook({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Obx(() {
        // Cek apakah data sedang dimuat
        bool isLoading = bookController.loadingFetchBook.value == DataLoad.loading;
        
        // Tampilkan container carousel meskipun data belum ada
        return bookController.listBook.isEmpty && !isLoading
            ? SizedBox.shrink() // Jika data kosong dan tidak loading, kosongkan
            : CarouselSlider(
                options: CarouselOptions(
                  height: 150,
                  aspectRatio: 0.95,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                ),
                items: List.generate(bookController.listBook.length, (index) {
                  final book = bookController.listBook.isNotEmpty
                      ? bookController.listBook[index]
                      : null;

                  final category = book != null
                      ? categoryController.listCategory.firstWhere(
                          (cat) => cat.id == int.tryParse(book.categoryId),
                          orElse: () => Category(
                            id: 0,
                            name: "Unknown",
                            description: "",
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                        )
                      : null;

                  // Jika sedang loading, tampilkan shimmer effect
                  if (isLoading) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        width: Get.width * 0.9,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                // Shimmer effect for image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(9),
                                  child: Container(
                                    width: 95,
                                    height: Get.height * 0.18,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Shimmer effect for title
                                      Container(
                                        height: 20,
                                        color: Colors.grey.shade300,
                                      ),
                                      SizedBox(height: 10),
                                      // Shimmer effect for author
                                      Container(
                                        height: 15,
                                        color: Colors.grey.shade300,
                                      ),
                                      SizedBox(height: 10),
                                      // Shimmer effect for published date
                                      Container(
                                        height: 15,
                                        width: 100,
                                        color: Colors.grey.shade300,
                                      ),
                                      SizedBox(height: 20),
                                      // Shimmer effect for category
                                      Container(
                                        height: 30,
                                        width: 90,
                                        color: Colors.grey.shade300,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  // Jika tidak sedang loading, tampilkan konten carousel
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
                          if (book != null) {
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
                          }
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
                                    book?.coverUrl ?? "",
                                    fit: BoxFit.cover,
                                    width: 95,
                                    height: Get.height * 0.18,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        book?.title ?? "Loading...",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        book?.author ?? "Loading...",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        book != null
                                            ? DateFormat.yMMMd()
                                                .format(book.publishedDate)
                                            : "Loading...",
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
                                            category?.name ?? "Loading...",
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
      }),
    );
  }
}
