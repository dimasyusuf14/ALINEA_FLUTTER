// import 'package:alinea/controller/cart/cart_controller.dart';
// import 'package:alinea/widgets/appbar/appbar_default.dart';
// import 'package:alinea/widgets/button/button_icon.dart';
// import 'package:alinea/services/utilities/asset_constant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CartPage extends StatelessWidget {
//   const CartPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final CartController controller = Get.put(CartController());

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
//                 if (controller.loadingFetchCart.value == DataLoad.loading) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (controller.loadingFetchCart.value ==
//                     DataLoad.failed) {
//                   return Center(
//                     child: Text("Gagal memuat keranjang. Coba lagi."),
//                   );
//                 } else if (controller.cartItems.isEmpty) {
//                   return Center(
//                     child: Text("Keranjang kosong."),
//                   );
//                 } else {
//                   return ListView.builder(
//                     itemCount: controller.cartItems.length,
//                     itemBuilder: (context, index) {
//                       final cartItem = controller.cartItems[index];
//                       return Container(
//                         margin: EdgeInsets.symmetric(
//                             vertical: 8.0, horizontal: 16.0),
//                         padding: EdgeInsets.all(12.0),
//                         decoration: BoxDecoration(
//                           color: Color(0XFFE0E8F9),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Obx(
//                               () => Checkbox(
//                                 value: cartItem.isChecked,
//                                 onChanged: (value) {
//                                   cartItem.isChecked = value ?? false;
//                                   controller.cartItems[index] =
//                                       cartItem; // Pastikan state di-update
//                                   controller.cartItems
//                                       .refresh(); // Menyegarkan observasi list
//                                 },
//                                 activeColor: Colors.blue,
//                               ),
//                             ),
//                             SizedBox(
//                               height: Get.height * 0.15,
//                               width: Get.width * 0.5,
//                               child: Image.network(
//                                 cartItem.book.coverUrl,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             SizedBox(width: 10),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     cartItem.book.title,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   SizedBox(height: 4),
//                                   Text(
//                                     cartItem.book.author,
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.grey[700],
//                                     ),
//                                   ),
//                                   SizedBox(height: 4),
//                                   Text(
//                                     cartItem.category.name,
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w600,
//                                       color: Color(0XFF1D4E89),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         right: 16, top: 8),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "Stok: ${cartItem.book.stock}",
//                                           style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w500,
//                                             color: Colors.grey[600],
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 35,
//                                           width: 35,
//                                           child: ButtonIcon(
//                                             onTap: () {
//                                               controller
//                                                   .deleteCartItem(cartItem.id);
//                                             },
//                                             icon: AssetConstant.icDelete,
//                                             bgcolor: Colors.transparent,
//                                             iccolor: Colors.red,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:alinea/controller/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alinea/models/cart/cart_model.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Obx(() {
        if (cartController.loadingFetchCart.value == DataLoad.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (cartController.loadingFetchCart.value == DataLoad.failed) {
          return Center(child: Text('Failed to load cart items.'));
        } else if (cartController.cartItems.isEmpty) {
          return Center(child: Text('No items in the cart.'));
        } else {
          return ListView.builder(
            itemCount: cartController.cartItems.length,
            itemBuilder: (context, index) {
              final CartModel cartItem = cartController.cartItems[index];
              return ListTile(
                leading: Image.network(cartItem.book.coverUrl), // URL Gambar
                title: Text(cartItem.book.title),
                subtitle: Text(cartItem.category.name),
                trailing: Text(cartItem.book.author),
              );
            },
          );
        }
      }),
    );
  }
}
