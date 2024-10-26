import 'package:alinea/models/home/home_model.dart';
import 'package:alinea/utilities/utilities.dart';
import 'package:get/get.dart';

class BookCarouselController extends GetxController {
  var loadingFetchBook = DataLoad.done.obs;
  var listBook = <HomeModel>[].obs;

  // Fetch books logic can be included here if needed
  // Or you can use the HomeController's data directly
}