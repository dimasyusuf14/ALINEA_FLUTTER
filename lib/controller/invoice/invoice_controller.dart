import 'dart:io';
import 'package:alinea/model/invoice/invoice_model.dart';
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
  var invoices = <InvoiceModel>[].obs;

  Future<void> downloadPDF(int id, String noInvoice) async {
    loadingFetchPdf.value = DataLoad.loading;

    try {
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
          return;
        }
      }

      Directory? downloadsDirectory;
      if (Platform.isAndroid) {
        downloadsDirectory = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        downloadsDirectory = await getApplicationDocumentsDirectory();
      }

      final filePath = "${downloadsDirectory!.path}/invoice_$noInvoice.pdf";
      final file = File(filePath);

      final url = "$kBaseUrl${APIEndpoint.pdfInvoice}/$id";
      final box = GetStorage();
      var token = box.read("token");
      final request = http.Request("GET", Uri.parse(url))
        ..headers.addAll({"Authorization": "Bearer $token"});

      final streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        final fileSink = file.openWrite();
        streamedResponse.stream.listen(
          (chunk) {
            fileSink.add(chunk);
          },
          onDone: () async {
            await fileSink.close();
            loadingFetchPdf.value = DataLoad.done;
            Get.snackbar(
              "Unduh Berhasil",
              "File PDF berhasil diunduh ke $filePath.",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          },
          onError: (e) async {
            await fileSink.close();
            loadingFetchPdf.value = DataLoad.failed;
            Get.snackbar(
              "Gagal",
              "Terjadi kesalahan saat mengunduh file.",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          },
        );
      } else {
        loadingFetchPdf.value = DataLoad.failed;
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
        "Terjadi kesalahan saat mengunduh file.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
