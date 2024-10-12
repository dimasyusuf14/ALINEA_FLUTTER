import 'package:alinea/models/home/home_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/utilities/api_constant.dart';
import 'package:alinea/utilities/utilities.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var loadingFetchBook = DataLoad.done.obs;
  var listBook = <HomeModel>[].obs;

  @override
  void onInit() {
    getListHome();
    super.onInit();
  }

  void getListHome() async {
    loadingFetchBook.value = DataLoad.loading;

    try {
      var data = await APIServices.api(
          endPoint: APIEndpoint.telik,
          type: APIMethod.get,
          withToken: false,
          param:
              '?sort[0]=ViewCount:desc&pagination[page]=1&pagination[pageSize]=20&fields[0]=title&fields[1]=Slug&fields[2]=createdAt&fields[3]=publishedAt&fields[4]=ViewCount&fields[4]=Content&populate[HeadlineImage][fields][0]=name&populate[HeadlineImage][fields][1]=url&populate[HeadlineImage][fields][2]=alternativeText&populate[category][fields][0]=Name&populate[category][fields][1]=Slug');
      if (data['data'] != null) {
        var dataList = data['data'] as List;
        List<HomeModel> list =
            dataList.map((e) => HomeModel.fromJson(e)).toList();
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
