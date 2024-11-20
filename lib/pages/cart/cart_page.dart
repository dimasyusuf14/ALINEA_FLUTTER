import 'package:alinea/controller/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alinea/models/cart/cart_model.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    cartController.fetchCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Saya'),
      ),
      body: Obx(() {
        if (cartController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (cartController.carts.isEmpty) {
          return Center(child: Text('Keranjang kosong.'));
        } else {
          return ListView.builder(
            itemCount: cartController.carts.length,
            itemBuilder: (context, index) {
              final CartModel cartItem = cartController.carts[index];
              return ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: cartItem.isChecked,
                      onChanged: (value) {
                        setState(() {
                          cartItem.isChecked = value ?? false;
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        cartItem.book.coverUrl,
                        width: 50,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image, size: 50);
                        },
                      ),
                    ),
                  ],
                ),
                title: Text(cartItem.book.title),
                subtitle: Text(cartItem.category?.name ?? 'Kategori tidak tersedia'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // cartController.deleteCartItem(cartItem.id);
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
