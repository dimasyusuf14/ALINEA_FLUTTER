import 'package:alinea/models/notif/notifikasi_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/utilities/api_constant.dart';
import 'package:alinea/utilities/utilities.dart';
import 'package:get/get.dart';

class NotifikasiController extends GetxController {


//TABBAR
  var selectedIndex = 0.obs;
  List<String> listTab = [
    "notifikasi",
    'peringatan',
  ];

  @override
  void onInit() {
    
    super.onInit();
  }


}
