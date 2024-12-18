import 'package:alinea/model/home/home_model.dart';
import 'package:alinea/model/invoice/history_invoice_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DendaController extends GetxController {
var loadingfetchDendaPeminjaman = DataLoad.loading.obs;
var listDendaPeminjaman = <HistoryInvoiceModel>[].obs;
var books = <BooksModel>[].obs;

@override
void onInit() {
  super.onInit();
  fetchDendaPeminjaman();
}

void fetchDendaPeminjaman() async {
  loadingfetchDendaPeminjaman.value = DataLoad.loading;
  try {
    var response = await APIServices.api(
      endPoint: APIEndpoint.myDenda,
      type: APIMethod.get,
      withToken: true,
    );

    if (response['data'] != null) {
      var dataList = response['data'] as List;

      List<HistoryInvoiceModel> books =
          dataList.map((e) => HistoryInvoiceModel.fromJson(e)).toList();

      books.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    listDendaPeminjaman.value = books;
      loadingfetchDendaPeminjaman.value = DataLoad.done;
    } else {
      loadingfetchDendaPeminjaman.value = DataLoad.failed;
    }
  } catch (e) {
    loadingfetchDendaPeminjaman.value = DataLoad.failed;
    logPrint("Error fetching invoices list: $e");
  }
}
String formatDate(String dateString) {
  try {
    // Parsing string ke objek DateTime
    final DateTime date = DateTime.parse(dateString);

    // Format tanggal ke "dd MMM yyyy"
    return DateFormat('dd MMM yyyy').format(date);
  } catch (e) {
    // Jika ada error, tampilkan string default
    return "-";
  }
}

}
