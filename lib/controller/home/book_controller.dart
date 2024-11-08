import 'package:alinea/models/home/home_model.dart';
import 'package:alinea/services/api_services.dart';
import 'package:alinea/services/utilities/api_constant.dart';
import 'package:alinea/services/utilities/utilities.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
  var loadingFetchBook = DataLoad.loading.obs;
  var listBook = <BooksModel>[].obs;
  var filteredBooks = <BooksModel>[].obs;
  var selectedCategoryId = 0.obs; // ID 0 for showing all books by default

  @override
  void onInit() {
    super.onInit();
    fetchBookList();
  }

  void fetchBookList() async {
    loadingFetchBook.value = DataLoad.loading;
    try {
      var response = await APIServices.api(
        endPoint: APIEndpoint.books,
        type: APIMethod.get,
        withToken: true,
      );

      if (response['data'] != null) {
        var dataList = response['data'] as List;

        List<BooksModel> books =
            dataList.map((e) => BooksModel.fromJson(e)).toList();

        books.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        listBook.value = books;
        filterBooksByCategory(); // Pastikan filter berdasarkan kategori
        loadingFetchBook.value = DataLoad.done;
      } else {
        loadingFetchBook.value = DataLoad.failed;
      }
    } catch (e) {
      loadingFetchBook.value = DataLoad.failed;
      print("Error fetching books: $e");
    }
  }

  void filterBooksByCategory([int? categoryId]) {
    selectedCategoryId.value = categoryId ?? selectedCategoryId.value;

    if (selectedCategoryId.value == 0) {
      // Show all books if no category is selected
      filteredBooks.value = listBook;
    } else {
      // Filter books by selected category ID
      filteredBooks.value = listBook
          .where(
              (book) => book.categoryId == selectedCategoryId.value.toString())
          .toList();
    }
  }
}
