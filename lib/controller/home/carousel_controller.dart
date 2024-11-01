import 'package:alinea/models/home/home_model.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:get/get.dart';

class BookCarouselController extends GetxController {
  var loadingFetchBook = DataLoad.done.obs;
  var listBook = <BooksModel>[].obs;

}