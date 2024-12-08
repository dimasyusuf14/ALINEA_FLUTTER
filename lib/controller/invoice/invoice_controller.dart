import 'dart:io';
import 'package:alinea/model/invoice/invoice_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class InvoiceController extends GetxController {
  var loadingFetchPdf = DataLoad.loading.obs;
  var downloadProgress = 0.0.obs;
  var invoice = <InvoiceModel>[].obs;

  Future<void> downloadPDF(int id) async {
    loadingFetchPdf.value = DataLoad.loading;
    try {
      // Panggil API endpoint dengan ID invoice sebagai parameter
      final response = await APIServices.api(
        endPoint: "${APIEndpoint.pdfInvoice}/$id", // Endpoint dinamis
        type: APIMethod.get,
        withToken: true,
      );

      if (response != null) {
        // Periksa izin penyimpanan
        if (Platform.isAndroid || Platform.isIOS) {
          var status = await Permission.storage.request();
          if (!status.isGranted) {
            Get.snackbar(
              "Izin Ditolak",
              "Mohon izinkan akses penyimpanan untuk mengunduh file.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            loadingFetchPdf.value = DataLoad.failed;
            return;
          }
        }

        // Tentukan lokasi penyimpanan file
        final directory = await getApplicationDocumentsDirectory();
        final filePath = "${directory.path}/invoice_$id.pdf";

        // Tulis byte data ke file lokal
        File file = File(filePath);
        await file.writeAsBytes(response);

        loadingFetchPdf.value = DataLoad.done;

        // Notifikasi berhasil
        Get.snackbar(
          "Unduh Berhasil",
          "File PDF berhasil diunduh ke $filePath.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        loadingFetchPdf.value = DataLoad.failed;
        Get.snackbar(
          "Gagal",
          "File PDF tidak ditemukan.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      loadingFetchPdf.value = DataLoad.failed;
      Get.snackbar(
        "Gagal",
        "Terjadi kesalahan saat mengunduh file: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("Error downloading PDF: $e");
    }
  }
}
