import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/widgets/appbar/appbar_default.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alinea/controller/cart/cart_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.put(CartController());
    return Scaffold(
      // backgroundColor: Color(0XFFE0E8F9),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBarDefault(
            title: "Keranjang Saya",
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: Get.height * 0.23,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Color(0XFFE0E8F9),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => Checkbox(
                            value: controller.checkC.value,
                            onChanged: (value) => controller.checkC.toggle(),
                            activeColor: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.35,
                          width: Get.width * 0.25,
                          child: Image.asset(AssetConstant.coverHarryPoter),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: Get.height * 0.20,
                          width: Get.width * 0.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Harry Potter and the Philosopher’s Stone",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                // maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "J.K Rowling",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                "Fiksi",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF1D4E89),
                                ),
                              ),
                              SizedBox(height: 30,),
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Hapus",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Stok: 20",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
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

