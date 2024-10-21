import 'package:alinea/controller/home/home_controller.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/utilities/asset_constant.dart';
import 'package:alinea/utilities/utilities.dart';
import 'package:alinea/widgets/appbar/appbar_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            height: Get.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
                right: 20,
                left: 20,
              ),
              child: Column(
                children: [
                  TextFormField(
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: Get.height * 0.2,
                    width: Get.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 145,
                          // width: 250,
                          child: Row(
                            children: [
                              Image.asset(
                                AssetConstant.sampul1,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height,
                          width: 170,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Anak Kecil Yang Kehilangan Pundaknya",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                              ),
                              Text("kljhjhkj"),
                              Text("kljhjhkj"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // Container(
          //   height: Get.height * 0.5,
          //   color: Colors.amber,
          //   child: Stack(
          //     children: [
          //       Expanded(
          //         child: Container(
          //           height: Get.height * 0.2,
          //           color: Colors.green,
          //         ),

          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
            child: Column(
              children: [
                // AppBarDefault(),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () {
                          if (controller.loadingFetchBook.value ==
                              DataLoad.loading) {
                            return Text(
                              "INI LOADING",
                              style: TextStyle(
                                fontSize: 32.0,
                              ),
                            );
                          } else if (controller.loadingFetchBook.value ==
                              DataLoad.failed) {
                            return Text(
                              "INI FAILED",
                              style: TextStyle(
                                fontSize: 32.0,
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: MasonryGridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 12,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 20,
                                padding: EdgeInsets.zero,
                                crossAxisCount: 3,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        RouteName.notifikasiPage,
                                        arguments:
                                            controller.listBook[index].id,
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          child: Image.network(
                                            controller
                                                .listBook[index]
                                                .attributes
                                                .HeadlineImage
                                                .data
                                                .attributes
                                                .url,
                                            width: Get.width,
                                            height: Get.height * 0.2,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          controller
                                              .listBook[index].attributes.Title,
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
