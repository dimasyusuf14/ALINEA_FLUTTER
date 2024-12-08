import 'dart:io';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/asset_constant.dart';
import 'package:alinea/widgets/button/button_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  File? pdfFile;

  @override
  void initState() {
    super.initState();
    fetchPdf('108'); // ID dokumen sebagai contoh
  }

  Future<void> fetchPdf(String id) async {
    try {
      // Panggil API untuk mendapatkan file PDF

      final response = await APIServices.api(
        endPoint: "${APIEndpoint.pdfInvoice}/$id", // Endpoint dinamis
        type: APIMethod.get,
        withToken: true,
      );

      if (response.statusCode == 200) {
        // Simpan PDF secara lokal
        final directory = await getTemporaryDirectory();
        final filePath = "${directory.path}/document_$id.pdf";
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        setState(() {
          pdfFile = file;
        });
      } else {
        print("Failed to fetch PDF: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching PDF: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top + 16,
              right: 16,
              left: 16,
              bottom: 20,
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                ButtonAction(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    AssetConstant.icBack,
                    width: 24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  "Dokumen Tambang Data",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: pdfFile != null
                ? SfPdfViewer.file(pdfFile!)
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
