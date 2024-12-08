import 'dart:convert';

import 'package:alinea/model/borrowing/borrowing_history.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BorrowingsController extends GetxController {
  var isLoading = false.obs;
  var borrowingsHistory = <BorrowingHistory>[].obs;

  // Variables for date input
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

  // String formatDateMMDDYYYY(DateTime? date) {
  //   if (date == null) return "-";
  //   return DateFormat('MM/dd/yyyy').format(date);
  // }

  String formatDate(DateTime? date) {
    if (date == null) return "-";
    return DateFormat('dd MMM yyyy').format(date);
  }

  /// Check if both dates are valid
  bool areDatesValid() {
    return borrowDate.value != null && returnDate.value != null;
  }

  /// Checkout API logic
  Future<bool> checkout(List<int> bookId) async {
    isLoading(true);

    var requestBodyMap = {
      "book_id": bookId,
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

      if (response != null && response['status'] == true) {
        logPrint("Checkout successful: ${response['message']}");
        fetchBorrowingsHistory(); // Refresh data after checkout
        return true; // Berhasil
      } else {
        logPrint("Checkout failed: ${response?['message'] ?? 'Unknown error'}");
        return false; // Gagal0
      }
    } catch (e) {
      logPrint("Checkout error: $e");
      return false; // Gagal
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
