 import 'dart:io';
import 'package:alinea/model/invoice/invoice_model.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:device_info_plus/device_info_plus.dart';
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

  /// Memeriksa izin penyimpanan/media berdasarkan versi Android
  Future<bool> checkStoragePermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt; // Dapatkan versi SDK Android

      if (sdkInt >= 33) {
        // Android 13 ke atas membutuhkan izin khusus media
        PermissionStatus imagesPermission = await Permission.photos.request();
        PermissionStatus videosPermission = await Permission.videos.request();
        PermissionStatus audioPermission = await Permission.audio.request();

        if (!imagesPermission.isGranted ||
            !videosPermission.isGranted ||
            !audioPermission.isGranted) {
          Get.snackbar(
            "Izin Ditolak",
            "Mohon izinkan akses media untuk melanjutkan.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return false;
        }
      } else {
        // Android 12 ke bawah hanya membutuhkan izin storage
        PermissionStatus storagePermission = await Permission.storage.request();
        if (!storagePermission.isGranted) {
          Get.snackbar(
            "Izin Ditolak",
            "Mohon izinkan akses penyimpanan untuk melanjutkan.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return false;
        }
      }
    }
    return true;
  }

  /// Mendapatkan path ke folder Download
  Future<Directory?> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      // Android menggunakan folder umum Download
      return Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      // iOS menggunakan application document directory
      return await getApplicationDocumentsDirectory();
    }
    return null;
  }

  /// Mengunduh file PDF dari server
  Future<void> downloadPDF(int id, String noInvoice) async {
    loadingFetchPdf.value = DataLoad.loading;

    try {
      // Memeriksa izin sebelum melanjutkan
      if (!await checkStoragePermission()) {
        loadingFetchPdf.value = DataLoad.failed;
        return;
      }

      // Mendapatkan path folder Download
      Directory? downloadsDirectory = await getDownloadDirectory();
      if (downloadsDirectory == null) {
        throw Exception("Direktori unduhan tidak ditemukan.");
      }

      final filePath = "${downloadsDirectory.path}/invoice_$noInvoice.pdf";
      final file = File(filePath);

      final url = "$kBaseUrl${APIEndpoint.pdfInvoice}/$id";
      final box = GetStorage();
      var token = box.read("token");

      final request = http.Request("GET", Uri.parse(url))
        ..headers.addAll({"Authorization": "Bearer $token"});

      final streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        final totalBytes = streamedResponse.contentLength ?? 1;
        final fileSink = file.openWrite();
        int downloadedBytes = 0;

        streamedResponse.stream.listen(
          (chunk) {
            fileSink.add(chunk);
            downloadedBytes += chunk.length;
            downloadProgress.value = downloadedBytes / totalBytes;
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
