import 'dart:convert';

import 'package:alinea/model/borrowing/borrowing_history.dart';
import 'package:alinea/model/home/home_model.dart';
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:alinea/widgets/button/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BorrowingsController extends GetxController {
  var isLoading = false.obs;
  var borrowingsHistory = <BorrowingHistory>[].obs;
  var books = <BooksModel>[].obs;

  // Variables for date input
  var bookId = 0.obs;
  var borrowDate = Rxn<DateTime>();
  var returnDate = Rxn<DateTime>();

  /// Fetch borrowing history
  Future<void> fetchBorrowingsHistory() async {
    isLoading(true);
    try {
      final response = await APIServices.api(
        endPoint: APIEndpoint.borrowingsHistory,
        type: APIMethod.get,
        withToken: true,
      );

      if (response != null) {
        final fetchedBorrowings = (response['data'] as List)
            .map((e) {
              try {
                return BorrowingHistory.fromJson(e);
              } catch (error) {
                logPrint("Error parsing BorrowingHistory: $error");
                return null;
              }
            })
            .whereType<BorrowingHistory>()
            .toList();

        // Clear old data and add new data
        borrowingsHistory.clear();
        borrowingsHistory.addAll(fetchedBorrowings);

        // Sort by most recent borrow date
        borrowingsHistory.sort((a, b) => b.borrowDate.compareTo(a.borrowDate));
      } else {
        logPrint("Failed to load borrowings history");
      }
    } catch (e) {
      logPrint("Fetch borrowings history error: $e");
    } finally {
      isLoading(false);
    }
  }

  void selectBorrowDuration(BuildContext context) async {
    final options = [7, 14, 21];
    final selectedOption = await showModalBottomSheet<int>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((duration) {
            return ListTile(
              title: Text("$duration Hari"),
              onTap: () {
                Navigator.pop(context, duration);
              },
            );
          }).toList(),
        );
      },
    );

    if (selectedOption != null) {
      borrowDate.value = DateTime.now(); // Tetapkan tanggal peminjaman hari ini
      returnDate.value = borrowDate.value!.add(Duration(days: selectedOption));
    }
  }



  String formatDate(DateTime? date) {
    if (date == null) return "-";
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Check if both dates are valid
  bool areDatesValid() {
    return borrowDate.value != null && returnDate.value != null;
  }


  Future<bool> checkout(List<int> bookIds, BuildContext context) async {
    isLoading(true);

    var requestBodyMap = {
      "book_id": bookIds,
      "borrow_date": formatDate(borrowDate.value),
      "return_date": formatDate(returnDate.value),
    };

    try {
      final response = await APIServices.api(
        endPoint: APIEndpoint.checkOut,
        type: APIMethod.post,
        withToken: true,
        requestBodyMap: requestBodyMap,
      );

      if (response != true) {
        if (response['status'] != true) {
          logPrint("Full response: $response");

          String errorMessage = response['message'] ?? 'Gagal meminjam buku.';
          Get.snackbar(
            "Warning",
            "Buku ini sudah dalam peminjaman anda!",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );

          logPrint("Checkout failed: $errorMessage");
          return false;
        }

        logPrint("Checkout successful: ${response['message']}");
        fetchBorrowingsHistory();

        // Tampilkan dialog konfirmasi
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                        Get.offNamed(RouteName.detailPeminjamanPage);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );

        return true;
      } else {
        Get.snackbar(
          "Kesalahan",
          "Tidak ada respons dari server. Silakan coba lagi.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        logPrint("No response from server");
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Kesalahan",
        "Terjadi kesalahan: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      logPrint("Checkout error: $e");
      return false;
    } finally {
      isLoading(false);
    }
  }

  /// Prepare checkout data
  Map<String, dynamic> prepareCheckoutData(int bookId) {
    if (!areDatesValid()) {
      logPrint("Invalid dates for checkout");
      return {};
    }

    return {
      'book_id': bookId,
      'borrow_date': DateFormat('dd/MM/yyyy').format(borrowDate.value!),
      'return_date': DateFormat('dd/MM/yyyy').format(returnDate.value!),
    };
  }
}
