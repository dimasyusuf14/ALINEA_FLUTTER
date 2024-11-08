import 'package:alinea/models/home/home_model.dart';
import 'package:alinea/pages/home/widgets/book_carousel.dart';
import 'package:alinea/pages/home/widgets/modal_category.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:alinea/controller/home/book_controller.dart';
import 'package:alinea/controller/home/categories_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final BookController controller = Get.put(BookController());
  final CategoriesController categoryController =
      Get.put(CategoriesController()); // Add CategoriesController

  Future<void> _refreshData() async {
    controller.selectedCategoryId.value = 0; // Reset kategori ke "semua"
    controller
        .fetchBookList(); // Memuat ulang daftar buku tanpa filter kategori
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFE0E8F9),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                color: Color(0XFF445DCC),
                height: Get.width * 0.52,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    right: 16,
                    left: 16,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextFormField(
                                autocorrect: false,
                                controller: TextEditingController(),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0XFFF1F4FD),
                                  hintText: "Cari Buku...",
                                  disabledBorder: InputBorder.none,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 50,
                            width: 50,
                            child: IconButton(
                              onPressed: () {
                                showCustomModal(context, controller);
                              },
                              icon: Icon(Icons.menu),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: Get.height * 0.15,
                left: Get.width * 0,
                right: Get.width * 0,
                child: CarouselBook(),
              ),
            ],
          ),
          SizedBox(height: 80),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Text(
                                  "Rak Buku",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Obx(() {
                                  if (controller.selectedCategoryId.value ==
                                      0) {
                                    // Jika kategori All (id = 0) dipilih, tampilkan 'All'
                                    return Text(
                                      " • All",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  } else {
                                    // Jika kategori lain dipilih, tampilkan nama kategori yang dipilih
                                    final selectedCategory = categoryController
                                        .listCategory
                                        .firstWhere(
                                      (category) =>
                                          category.id ==
                                          controller.selectedCategoryId.value,
                                      // fallback
                                    );
                                    return Text(
                                      " • ${selectedCategory.name}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  }
                                }),
                              ],
                            ),
                          ),
                          Obx(
                            () {
                              if (controller.loadingFetchBook.value ==
                                  DataLoad.loading) {
                                return CircularProgressIndicator();
                              } else if (controller.loadingFetchBook.value ==
                                  DataLoad.failed) {
                                return Text(
                                  "FAILED",
                                  style: TextStyle(fontSize: 32.0),
                                );
                              } else {
                                final booksToDisplay =
                                    controller.filteredBooks.isNotEmpty
                                        ? controller.filteredBooks
                                        : controller.listBook;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  child: MasonryGridView.count(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: booksToDisplay.length,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 20,
                                    padding: EdgeInsets.zero,
                                    crossAxisCount: 3,
                                    itemBuilder: (context, index) {
                                      final book = booksToDisplay[index];
                                      return InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                            RouteName.detailPage,
                                            arguments: {
                                              'title': book.title,
                                              'author': book.author,
                                              'description': book.description,
                                              'coverUrl': book.coverUrl,
                                              'category_id': book.categoryId,
                                              'published_date':
                                                  book.publishedDate,
                                            },
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              child: Image.network(
                                                book.coverUrl,
                                                width: Get.width,
                                                height: Get.height * 0.2,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              book.title,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
