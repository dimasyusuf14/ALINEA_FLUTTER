import 'dart:ui';

import 'package:alinea/controller/borrowing/borrowing_controller.dart';
import 'package:alinea/controller/cart/cart_controller.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/appbar/appbar_default.dart';
import 'package:alinea/widgets/appbar/appbar_secondary.dart';
import 'package:alinea/widgets/button/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CheckOutPage extends StatelessWidget {
  CheckOutPage({super.key});
  final BorrowingsController controller = Get.put(BorrowingsController());
  CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    final selectedBooks = Get.arguments as List<Map<String, dynamic>>?;

    return Scaffold(
      body: Column(
        children: [
          AppBarSecondary(
            title: "Checkout",
          ),
          Expanded(
            child: selectedBooks == null || selectedBooks.isEmpty
                ? Center(child: Text("Tidak ada buku yang dipilih."))
                : ListView.builder(
                    itemCount: selectedBooks.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final book = selectedBooks[index];
                      return Container(
                        color: const Color(0XFFE0E8F9),
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 80,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  book['coverUrl'],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.broken_image,
                                        size: 70);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ), // Spasi antara gambar dan teks
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book['title'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    book['author'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("x1"),
                                ],
                              ),
                            ),
                            // Spasi antara gambar dan teks
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Obx(
                    () => TextButton(
                      onPressed: () => controller.selectBorrowDate(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pengambilan:   ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          Text(
                            controller.formatDate(controller.borrowDate.value),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kColorPrimary),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            color: kColorPrimary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pengembalian:",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          Text(
                            controller.formatDate(controller.returnDate.value),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kColorPrimary),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            color: kColorPrimary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    children: [
                      TextSpan(
                          text: "Tanggal pengembalian otomatis terhitung "),
                      TextSpan(
                        text: "7 hari",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(text: " setelah memilih tanggal pengambilan."),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Buttonprimary(
                  title: "Konfirmasi",
                  color: kColorPrimary,
                  width: Get.width,
                  fontSize: 18,
                  onPressed: () {
                    final bookIds = selectedBooks
                            ?.map<int>((book) => book['id'])
                            .toList() ??
                        [];

                    if (bookIds.isEmpty) {
                      Get.snackbar(
                        "Peringatan",
                        "Tidak ada buku yang dipilih.",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } else {
                      // Proses checkout
                      controller.checkout(bookIds).then((status) {
                        if (status = true) {
                          // Hapus item yang berhasil di-checkout dari keranjang
                          cartController.removeCheckedItems();
                          // Gunakan custom dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 24,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0XFFC9D6F4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        AssetConstant.icCheck,
                                        width: 50,
                                        color: kColorPrimary,
                                      ),
                                      SizedBox(height: 24),
                                      Text(
                                        "Checkout Berhasil",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text("Buku Anda berhasil di-checkout."),
                                      SizedBox(height: 24),
                                      Buttonprimary(
                                        fontSize: 16,
                                        title: "Lihat detail peminjaman saya",
                                        color: kColorPrimary,
                                        width: Get.width,
                                        onPressed: () {
                                          Get.offNamed(
                                              RouteName.detailPeminjamanPage);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          Get.snackbar(
                            "Gagal",
                            "Proses checkout gagal. Coba lagi.",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}