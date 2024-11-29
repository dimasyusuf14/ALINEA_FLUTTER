import 'dart:convert';

import 'package:alinea/model/borrowing/borrowing_history.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BorrowingsController extends GetxController {
  var isLoading = false.obs;
  var borrowings = <BorrowingHistory>[].obs;

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

        // Hapus data lama dan tambahkan data terbaru
        borrowings.clear();
        borrowings.addAll(fetchedBorrowings);

        // Urutkan berdasarkan tanggal peminjaman terbaru
        borrowings.sort((a, b) => b.borrowDate.compareTo(a.borrowDate));
      } else {
        logPrint("Failed to load borrowings history");
      }
    } catch (e) {
      logPrint("Fetch borrowings history error: $e");
    } finally {
      isLoading(false);
    }
  }
}
