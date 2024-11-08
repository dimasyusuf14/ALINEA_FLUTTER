import 'package:alinea/models/home/home_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:get/get.dart';

// class CategoriesController extends GetxController {
//   var loadingFetchCategories = DataLoad.done.obs;

//   @override
//   void onInit() {
//     getProductList();
//     super.onInit();
//   }

//   void getProductList() async {
//     loadingFetchCategories.value = DataLoad.loading;

//     try {
//       var data = await APIServices.api(
//         endPoint: APIEndpoint.categories,
//         type: APIMethod.get,
//         withToken: true,

//       );

//       if (data['data'] != null) {
//         var dataList = data['data'] as List;
//         dataList.map((e) => BooksModel.fromJson(e)).toList();
//         // listBook.value = list;

//         loadingFetchCategories.value = DataLoad.done;
//       } else {
//         loadingFetchCategories.value = DataLoad.failed;
//       }
//     } catch (e) {
//       loadingFetchCategories.value = DataLoad.failed;
//     }
//   }
// }

class CategoriesController extends GetxController {
  var loadingFetchCategories = DataLoad.done.obs;
  var listCategory = <Category>[].obs;

  @override
  void onInit() {
    getProductList();
    super.onInit();
  }

  void getProductList() async {
    loadingFetchCategories.value = DataLoad.loading;

    try {
      var data = await APIServices.api(
        endPoint: APIEndpoint.categories,
        type: APIMethod.get,
        withToken: true,
      );

      if (data['data'] != null) {
        var dataList = data['data'] as List;
        listCategory.value = dataList.map((e) => Category.fromJson(e)).toList();
        loadingFetchCategories.value = DataLoad.done;
      } else {
        loadingFetchCategories.value = DataLoad.failed;
      }
    } catch (e) {
      loadingFetchCategories.value = DataLoad.failed;
    }
  }
}
