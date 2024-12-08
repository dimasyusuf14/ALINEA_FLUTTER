import 'package:alinea/model/home/home_model.dart';
import 'package:alinea/model/invoice/history_invoice_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RiwayatInvoiceController extends GetxController {
  var loadingFetchHistoryPeminjaman = DataLoad.loading.obs;
  var listHistoryPeminjaman = <HistoryInvoiceModel>[].obs;
  var books = <BooksModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistoryPeminjaman();
  }

  void fetchHistoryPeminjaman() async {
    loadingFetchHistoryPeminjaman.value = DataLoad.loading;
    try {
      var response = await APIServices.api(
        endPoint: APIEndpoint.invoice,
        type: APIMethod.get,
        withToken: true,
      );

      if (response['data'] != null) {
        var dataList = response['data'] as List;

        List<HistoryInvoiceModel> books =
            dataList.map((e) => HistoryInvoiceModel.fromJson(e)).toList();

        books.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        listHistoryPeminjaman.value = books;
        loadingFetchHistoryPeminjaman.value = DataLoad.done;
      } else {
        loadingFetchHistoryPeminjaman.value = DataLoad.failed;
      }
    } catch (e) {
      loadingFetchHistoryPeminjaman.value = DataLoad.failed;
      logPrint("Error fetching invoices list: $e");
    }
  }

  String formatDate(String dateString) {
    try {
      final DateTime date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
