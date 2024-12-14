import 'package:get/get.dart';
import 'package:alinea/model/notif/notifikasi_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';

class NotifikasiController extends GetxController {
  var selectedIndex = 0.obs;
  var loadingFetchNotification = DataLoad.loading.obs; // Initialize loading state
  var listNotification = <NotificationsModel>[].obs; // Reactive list of notifications

  List<String> listTab = [
    "Notifikasi",
    "Peringatan",
  ];

  @override
  void onInit() {
    fetchNotifications(); // Fetch notifications when controller is initialized
    super.onInit();
  }

  void fetchNotifications() async {
    loadingFetchNotification.value = DataLoad.loading;
    try {
      var response = await APIServices.api(
        endPoint: APIEndpoint.myNotification,
        type: APIMethod.get,
        withToken: true,
      );

      if (response['data'] != null) {
        var dataList = response['data'] as List;

        List<NotificationsModel> notifications =
            dataList.map((e) => NotificationsModel.fromJson(e)).toList();

        notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        listNotification.value = notifications;
        loadingFetchNotification.value = DataLoad.done;
      } else {
        loadingFetchNotification.value = DataLoad.failed;
      }
    } catch (e) {
      loadingFetchNotification.value = DataLoad.failed;
      print("Error fetching notifications: $e");
    }
  }
}
