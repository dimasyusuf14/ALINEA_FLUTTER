import 'package:alinea/controller/home/home_controller.dart';
import 'package:alinea/pages/home/widgets/book_carousel.dart';
import 'package:alinea/pages/home/widgets/modal_category.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/appbar/appbar_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomeController controller = Get.put(HomeController());
  final box = GetStorage(); // Initialize GetStorage

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
                    right: 20,
                    left: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: Get.width * 0.73,
                            child: TextFormField(
                              autocorrect: false,
                              controller: SearchController(),
                              keyboardType: TextInputType.emailAddress,
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
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 50,
                            width: 50,
                            child: IconButton(
                              onPressed: () {
                                showCustomModal(context);
                              },
                              icon: Icon(Icons.menu),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: Get.height * 0.15,
                left: Get.width * 0,
                right: Get.width * 0,
                child: CarouselBook(),
              ), //panggil carousel
            ],
          ),
          SizedBox(
            height: 80,
          ),
          Expanded(
            child: Column(
              children: [
                // AppBarDefault(),

                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: const [
                            Text(
                              "Rak Buku",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Obx(
                      //   () {
                      //     if (controller.loadingFetchBook.value ==
                      //         DataLoad.loading) {
                      //       return Text(
                      //         "LOADING",
                      //         style: TextStyle(
                      //           fontSize: 32.0,
                      //         ),
                      //       );
                      //     } else if (controller.loadingFetchBook.value ==
                      //         DataLoad.failed) {
                      //       return Text(
                      //         "FAILED",
                      //         style: TextStyle(
                      //           fontSize: 32.0,
                      //         ),
                      //       );
                      //     } else {
                      //       return Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //           horizontal: 16,
                      //           vertical: 10,
                      //         ),
                      //         child: MasonryGridView.count(
                      //           physics: const NeverScrollableScrollPhysics(),
                      //           shrinkWrap: true,
                      //           itemCount: 12,
                      //           crossAxisSpacing: 15,
                      //           mainAxisSpacing: 20,
                      //           padding: EdgeInsets.zero,
                      //           crossAxisCount: 3,
                      //           itemBuilder: (context, index) {
                      //             return InkWell(
                      //               onTap: () {
                      //                 Get.toNamed(
                      //                   RouteName.detailPage,
                      //                   arguments:
                      //                       controller.listBook[index].id,
                      //                 );
                      //               },
                      //               child: Column(
                      //                 children: [
                      //                   ClipRRect(
                      //                     borderRadius:
                      //                         BorderRadius.circular(9),
                      //                     child: Image.network(
                      //                       controller
                      //                           .listBook[index]
                      //                           .attributes
                      //                           .HeadlineImage
                      //                           .data
                      //                           .attributes
                      //                           .url,
                      //                       width: Get.width,
                      //                       height: Get.height * 0.2,
                      //                       fit: BoxFit.cover,
                      //                     ),
                      //                   ),
                      //                   Text(
                      //                     controller
                      //                         .listBook[index].attributes.Title,
                      //                     style: TextStyle(
                      //                       fontSize: 12.0,
                      //                     ),
                      //                     maxLines: 1,
                      //                     overflow: TextOverflow.ellipsis,
                      //                   ),
                      //                 ],
                      //               ),
                      //             );
                      //           },
                      //         ),
                      //       );
                      //     }
                      //   },
                      // ),

                      Obx(
                        () {
                          if (controller.loadingFetchBook.value ==
                              DataLoad.loading) {
                            return Text(
                              "LOADING",
                              style: TextStyle(
                                fontSize: 32.0,
                              ),
                            );
                          } else if (controller.loadingFetchBook.value ==
                              DataLoad.failed) {
                            return Text(
                              "FAILED",
                              style: TextStyle(
                                fontSize: 32.0,
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: MasonryGridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.listBook.length,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 20,
                                padding: EdgeInsets.zero,
                                crossAxisCount: 3,
                                itemBuilder: (context, index) {
                                  final book = controller.listBook[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        RouteName.detailPage,
                                        arguments: book.id,
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          child: Image.network(
                                        'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg' ,   // book.cover,
                                        
                                            width: Get.width,
                                            height: Get.height * 0.2,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          book.title,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
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
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
