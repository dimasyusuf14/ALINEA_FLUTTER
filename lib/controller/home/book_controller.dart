import 'package:alinea/models/home/home_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
  var loadingFetchBook = DataLoad.done.obs;
  var listBook = <BooksModel>[].obs;

  @override
  void onInit() {
    getProductList();
    super.onInit();
  }

  void getProductList() async {
    loadingFetchBook.value = DataLoad.loading;

    try {
      var data = await APIServices.api(
        endPoint: APIEndpoint.books,
        type: APIMethod.get,
        withToken: true,
      );

      if (data['data'] != null) {
        var dataList = data['data'] as List;

        // Map the JSON to BooksModel instances
        List<BooksModel> list =
            dataList.map((e) => BooksModel.fromJson(e)).toList();

        // Sort the list based on created_at in descending order
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        // Assign the sorted list to the observable
        listBook.value = list;

        loadingFetchBook.value = DataLoad.done;
      } else {
        loadingFetchBook.value = DataLoad.failed;
      }
    } catch (e) {
      loadingFetchBook.value = DataLoad.failed;
    }
  }
}


