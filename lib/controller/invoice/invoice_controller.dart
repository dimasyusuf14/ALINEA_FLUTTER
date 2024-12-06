import 'package:alinea/model/borrowing/borrowing_model.dart';
import 'package:alinea/model/home/home_model.dart';
import 'package:alinea/model/invoice/history_invoice_model.dart';
import 'package:alinea/model/login/user_model.dart';
import 'package:alinea/model/invoice/invoice_model.dart'; // Make sure this path matches your actual model path
import 'package:alinea/routes/route_name.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class InvoiceController extends GetxController {
  var invoices = <HistoryInvoiceModel>[].obs;
  var borrow = <BorrowingModel>[].obs;
  var books = <BooksModel>[].obs;
  var loadingFetchInvoice = DataLoad.loading.obs;

  // var noInvoice = ''.obs;
  // var id = 0.obs;

  @override
  void onInit() {
    // id.value = Get.arguments[0];
    // noInvoice.value = Get.arguments[1];
    fetchInvoices();

    super.onInit();
  }

  Future<void> fetchInvoices() async {
    loadingFetchInvoice.value = DataLoad.loading;
    try {
      var response = await APIServices.api(
          endPoint: APIEndpoint.detailInvoice,
          type: APIMethod.get,
          withToken: true,
          param: "/81");

      if (response['data'] != null) {
        var dataList = response['data'] as List;

        List<HistoryInvoiceModel> fetchedInvoices =
            dataList.map((e) => HistoryInvoiceModel.fromJson(e)).toList();

        invoices.assignAll(fetchedInvoices);

        loadingFetchInvoice.value = DataLoad.done;
        loadingFetchInvoice.value = DataLoad.failed;
      }
    } catch (e) {
      loadingFetchInvoice.value = DataLoad.failed;
      logPrint("Error fetching invoices: $e");
    }
  }
}
