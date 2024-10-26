import 'package:alinea/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alinea/controller/home/home_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselBook extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  CarouselBook({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Obx(() {
        if (controller.loadingFetchBook.value == DataLoad.loading) {
          return Center(
            child: Text(
              "Loading...",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          );
        } else if (controller.loadingFetchBook.value == DataLoad.failed) {
          return Center(
            child: Text(
              "Failed to load data",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          );
        } else if (controller.listBook.isEmpty) {
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
            carouselController: CarouselSliderController(),
            items: List.generate(10, (index) {
              final book = controller.listBook[index];
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  // width: Get.width * 0.7,
                  // height: Get.height * 0.2,
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
                            book.attributes.HeadlineImage.data.attributes.url,
                            fit: BoxFit.cover,
                            width: 95,
                            height: Get.height * 0.18,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.attributes.Title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Nama Penulis",
                                style: TextStyle(fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
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
