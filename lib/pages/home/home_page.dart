import 'package:alinea/model/home/home_model.dart';
import 'package:alinea/pages/home/widgets/book_carousel.dart';
import 'package:alinea/pages/home/widgets/modal_category.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/shimmer/shimmer_grid.dart';
import 'package:alinea/widgets/shimmer/shimmer_loading.dart';
import 'package:alinea/widgets/try_again_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:alinea/controller/home/book_controller.dart';
import 'package:alinea/controller/home/categories_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:shimmer/shimmer.dart'; // Import shimmer

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final BookController controller = Get.put(BookController());
  final CategoriesController categoryController =
      Get.put(CategoriesController()); // Add CategoriesController
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF1F4FD),
      body: Column(
        children: [
          Container(
            color: Color(0XFF445DCC),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              onChanged: (query) {
                                controller.searchQuery.value = query;
                                controller.filterBooks();
                              },
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
                  ),
                  SizedBox(height: 16),
                  CarouselBook(),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: refreshController,
              onRefresh: () async {
                controller.fetchBookList();
                refreshController.refreshCompleted();
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                                if (controller.selectedCategoryId.value == 0) {
                                  return Text(
                                    " • All",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: kColorSecondary,
                                    ),
                                  );
                                } else {
                                  final selectedCategory = categoryController
                                      .listCategory
                                      .firstWhere((category) =>
                                          category.id ==
                                          controller.selectedCategoryId.value);
                                  return Text(
                                    " • ${selectedCategory.name}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: kColorSecondary,
                                    ),
                                  );
                                }
                              }),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Obx(() {
                            if (controller.loadingFetchBook.value ==
                                DataLoad.loading) {
                              return MasonryGridView.count(
                                crossAxisCount: 3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 20,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 20,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return ShimmerBooks();
                                },
                              );
                            } else if (controller.loadingFetchBook.value ==
                                DataLoad.failed) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(9),
                                child: TryAgainWidget(
                                  child: ShimmerGrid(count: 6, heightCard: 120),
                                  onTapTryAgain: () async {
                                    refreshController.refreshCompleted();
                                    controller.fetchBookList();
                                  },
                                ),
                              );
                            } else {
                              final booksToDisplay =
                                  controller.filteredBooks.isNotEmpty
                                      ? controller.filteredBooks
                                      : controller.listBook;

                              return MasonryGridView.count(
                                padding: EdgeInsets.zero,
                                crossAxisCount: 3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 20,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: booksToDisplay.length,
                                itemBuilder: (context, index) {
                                  final book = booksToDisplay[index];
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(9),
                                    onTap: () {
                                      Get.toNamed(
                                        RouteName.detailPage,
                                        arguments: {
                                          'id': book.id,
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
                                        SizedBox(height: 4),
                                        Text(
                                          book.title,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          book.author,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          }),
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
