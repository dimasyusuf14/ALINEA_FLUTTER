import 'package:alinea/controller/home/home_controller.dart';
import 'package:alinea/routes/route_name.dart';
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBarDefault(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () {
                    if (controller.loadingFetchBook.value == DataLoad.loading) {
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
                      return MasonryGridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 20,
                        padding: EdgeInsets.zero,
                        crossAxisCount: 3,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(
                                RouteName.notifikasiPage,
                                arguments: controller.listBook[index].id,
                              );
                            },
                            child: Column(
                              children: [
                                Image.network(
                                  controller.listBook[index].attributes
                                      .HeadlineImage.data.attributes.url,
                                  width: Get.width,
                                  height: Get.height * 0.3,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  controller.listBook[index].attributes.Title,
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
                      );
                    }
                  },
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
