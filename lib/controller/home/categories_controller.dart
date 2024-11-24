import 'package:alinea/model/home/home_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  var loadingFetchCategories = DataLoad.loading.obs;
  var listCategory = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryList();
  }

  // Fetches the list of categories from the API
  void fetchCategoryList() async {
    loadingFetchCategories.value = DataLoad.loading;
    try {
      var response = await APIServices.api(
        endPoint: APIEndpoint.categories,
        type: APIMethod.get,
        withToken: true,
      );

      if (response['data'] != null) {
        var dataList = response['data'] as List;

        // Map the JSON response to a list of Category instances
        listCategory.value = dataList.map((e) => Category.fromJson(e)).toList();
        loadingFetchCategories.value = DataLoad.done;
      } else {
        loadingFetchCategories.value = DataLoad.failed;
      }
    } catch (e) {
      loadingFetchCategories.value = DataLoad.failed;
      print("Error fetching categories: $e");
    }
  }
}
