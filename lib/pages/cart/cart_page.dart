import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/appbar/appbar_default.dart';
import 'package:alinea/widgets/button/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alinea/controller/cart/cart_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: Color(0XFFF1F4FD),
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
                            activeColor: kColorPrimary,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Harry Potter and the Philosopher’s Stone",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Text(
                                "J.K Rowling",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Text(
                                "Fiksi",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF1D4E89),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Stok: 20",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: ButtonIcon(
                                        onTap: () {},
                                        icon: AssetConstant.icDelete,
                                        bgcolor: Colors.transparent,
                                        iccolor: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
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

// class CartPage extends StatelessWidget {
//   const CartPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     CartController controller = Get.put(CartController());
//     return Scaffold(
//       backgroundColor: Color(0XFFF1F4FD),
//       body: Column(
//         children: [
//           AppBarDefault(
//             title: "Keranjang Saya",
//           ),
//           Expanded(
//             child: Obx(
//               () {
//                 // Ensure there are cart items before rendering
//                 if (controller.cartItems.isEmpty) {
//                   return Center(
//                     child: Text("Your cart is empty."),
//                   );
//                 }
//                 return SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: Column(
//                     children: List.generate(
//                       controller.cartItems.length,
//                       (index) {
//                         final item = controller.cartItems[index];
//                         return Container(
//                           height: Get.height * 0.23,
//                           width: Get.width,
//                           decoration: BoxDecoration(
//                             color: Color(0XFFE0E8F9),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Obx(
//                                 () => Checkbox(
//                                   value: controller.checkC.value,
//                                   onChanged: (value) => controller.checkC.toggle(),
//                                   activeColor: Colors.blue,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: Get.height * 0.35,
//                                 width: Get.width * 0.25,
//                                 child: Image.asset(AssetConstant.coverHarryPoter), // You might want to update this dynamically as well
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               SizedBox(
//                                 height: Get.height * 0.20,
//                                 width: Get.width * 0.6,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       item.bookId.toString(),  // Use actual book title here
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     Text(
//                                       "Book Author", // Use the actual author
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.grey[700],
//                                       ),
//                                     ),
//                                     Text(
//                                       "Fiction", // You can update this to the actual category if available
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w600,
//                                         color: Color(0XFF1D4E89),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 16),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             "Stock: 20", // Adjust this to show actual stock
//                                             style: TextStyle(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.grey[600],
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 35,
//                                             width: 35,
//                                             child: ButtonIcon(
//                                               onTap: () {
//                                                 // Handle delete action
//                                               },
//                                               icon: AssetConstant.icDelete,
//                                               bgcolor: Colors.transparent,
//                                               iccolor: Colors.red,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
