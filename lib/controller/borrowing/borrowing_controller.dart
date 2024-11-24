import 'package:alinea/model/borrowing/borrowing_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BorrowingController extends GetxController {
  var isLoading = false.obs;
  var borrowings = <BorrowingModel>[].obs;

  // Periksa apakah buku sedang dipinjam oleh pengguna
  bool isBookBorrowed(int bookId) {
    return borrowings.any((borrowing) => borrowing.book.id == bookId);
  }

  // Ambil data peminjaman
  // Future<void> fetchBorrowings() async {
  //   isLoading(true);
  //   try {
  //     final response = await APIServices.api(
  //       endPoint: APIEndpoint.borrowings,
  //       type: APIMethod.get,
  //       withToken: true,
  //     );

  //     if (response != null) {
  //       final fetchedBorrowings = (response['data'] as List)
  //           .map((e) {
  //             try {
  //               return BorrowingModel.fromJson(e);
  //             } catch (e) {
  //               logPrint("Error parsing BorrowingModel: $e");
  //               return null;
  //             }
  //           })
  //           .whereType<BorrowingModel>()
  //           .toList();

  //       // Hapus data lama dan tambahkan data baru
  //       borrowings.clear();
  //       borrowings.addAll(fetchedBorrowings);

  //       // Urutkan data berdasarkan tanggal peminjaman terbaru
  //       borrowings.sort((a, b) => b.borrowDate.compareTo(a.borrowDate));
  //     } else {
  //       logPrint("Failed to load borrowings");
  //     }
  //   } catch (e) {
  //     logPrint("Fetch error: $e");
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  // Tambahkan peminjaman baru
  Future<void> addBorrowing(int bookId, DateTime borrowDate, DateTime returnDate) async {
    try {

      final response = await APIServices.api(
        endPoint: APIEndpoint.checkOut,
        type: APIMethod.post,
        withToken: true,
        // data: payload,
      );

      if (response != null && response['status'] == true) {
        final newBorrowing = BorrowingModel.fromJson(response['data']);
        borrowings.insert(0, newBorrowing); // Tambahkan peminjaman ke awal daftar

        // Notifikasi keberhasilan
        Get.snackbar(
          "Berhasil",
          "Peminjaman buku berhasil ditambahkan.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.greenAccent,
          colorText: Colors.white,
        );
      } else {
        // Notifikasi kegagalan
        Get.snackbar(
          "Gagal",
          "Buku sudah dipinjam atau terjadi kesalahan.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      logPrint("Add borrowing error: $e");
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat menambahkan peminjaman.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  // Hapus peminjaman
  // Future<void> deleteBorrowing(int borrowingId) async {
  //   try {
  //     final response = await APIServices.api(
  //       endPoint: APIEndpoint.deleteBorrowing.replaceFirst("{borrowingId}", borrowingId.toString()),
  //       type: APIMethod.delete,
  //       withToken: true,
  //     );

  //     if (response != null && response['status'] == true) {
  //       borrowings.removeWhere((borrowing) => borrowing.id == borrowingId);
  //       borrowings.refresh();
  //       fetchBorrowings(); // Refresh data setelah penghapusan

  //       // Notifikasi keberhasilan
  //       Get.snackbar(
  //         "Berhasil",
  //         "Peminjaman berhasil dihapus.",
  //         snackPosition: SnackPosition.TOP,
  //         backgroundColor: Colors.greenAccent,
  //         colorText: Colors.white,
  //       );
  //     } else {
  //       // Notifikasi kegagalan
  //       Get.snackbar(
  //         "Gagal",
  //         "Gagal menghapus peminjaman.",
  //         snackPosition: SnackPosition.TOP,
  //         backgroundColor: Colors.redAccent,
  //         colorText: Colors.white,
  //       );
  //     }
  //   } catch (e) {
  //     logPrint("Delete borrowing error: $e");
  //     Get.snackbar(
  //       "Error",
  //       "Terjadi kesalahan saat menghapus peminjaman.",
  //       snackPosition: SnackPosition.TOP,
  //       backgroundColor: Colors.redAccent,
  //       colorText: Colors.white,
  //     );
  //   }
  // }
}
