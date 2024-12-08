import 'dart:io';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class InvoiceController extends GetxController {
  var loadingFetchPdf = DataLoad.loading.obs;
  var downloadProgress = 0.0.obs;

  Future<void> downloadPDF(int id) async {
    loadingFetchPdf.value = DataLoad.loading;
    print("Starting download for invoice ID: $id");

    try {
      // Periksa izin penyimpanan
      if (Platform.isAndroid || Platform.isIOS) {
        var status = await Permission.storage.request();
        if (!status.isGranted) {
          Get.snackbar(
            "Izin Ditolak",
            "Mohon izinkan akses penyimpanan untuk mengunduh file.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          loadingFetchPdf.value = DataLoad.failed;
          print("Storage permission denied.");
          return;
        }
      }

      // Tentukan lokasi penyimpanan file di folder Downloads
      Directory? downloadsDirectory;
      if (Platform.isAndroid) {
        downloadsDirectory = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        downloadsDirectory = await getApplicationDocumentsDirectory(); // iOS tidak memiliki folder Downloads yang sama
      }

      final filePath = "${downloadsDirectory!.path}/invoice_$id.pdf";
      final file = File(filePath);
      print("File will be saved to: $filePath");

      // Hit API langsung menggunakan http untuk mengunduh file
      final url = "$kBaseUrl${APIEndpoint.pdfInvoice}/$id"; // Endpoint dinamis
      print("Requesting URL: $url");
      final box = GetStorage();
      var token = box.read("token");
      final request = http.Request("GET", Uri.parse(url))
        ..headers.addAll({
          "Authorization": "Bearer $token"
        }); // Tambahkan token jika diperlukan

      final streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        print("Response received, status code: ${streamedResponse.statusCode}");
        // Simpan file secara streaming
        final fileSink = file.openWrite();
        await streamedResponse.stream.listen(
          (chunk) {
            fileSink.add(chunk);
          },
          onDone: () async {
            await fileSink.close();
            loadingFetchPdf.value = DataLoad.done;

            // Notifikasi berhasil
            Get.snackbar(
              "Unduh Berhasil",
              "File PDF berhasil diunduh ke $filePath.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            print("File downloaded successfully.");
          },
          onError: (e) async {
            await fileSink.close();
            loadingFetchPdf.value = DataLoad.failed;
            Get.snackbar(
              "Gagal",
              "Terjadi kesalahan saat mengunduh file: $e",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            print("Error while downloading file: $e");
          },
        );
      } else {
        loadingFetchPdf.value = DataLoad.failed;
        print("Failed to download file, status code: ${streamedResponse.statusCode}");
        Get.snackbar(
          "Gagal",
          "File PDF tidak ditemukan.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      loadingFetchPdf.value = DataLoad.failed;
      Get.snackbar(
        "Gagal",
        "Terjadi kesalahan saat mengunduh file: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("Error downloading PDF: $e");
    }
  }
}