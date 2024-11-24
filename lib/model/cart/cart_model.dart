import 'package:alinea/model/home/home_model.dart';
import 'package:alinea/model/login/user_model.dart';
import 'package:get/get.dart';

class CartModel {
  final int id;
  final int? userId; // Allow null
  final int? bookId; // Allow null
  final DateTime createdAt;
  final DateTime updatedAt;
  final BooksModel book;
  final Category? category; // Allow null
  final UserModel? user; // Allow null
  final RxBool isChecked;

  CartModel({
    required this.id,
    this.userId,
    this.bookId,
    required this.createdAt,
    required this.updatedAt,
    required this.book,
    this.category,
    this.user,
    bool isChecked = false,
  }) : isChecked = RxBool(isChecked);

  factory CartModel.fromJson(Map<String, dynamic> json) {
    // Cek dan parsing tanggal dengan lebih aman
    DateTime parseDate(String? date) {
      return DateTime.tryParse(date ?? '') ?? DateTime(1970, 1, 1);
    }

    return CartModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] != null ? int.tryParse(json['user_id'].toString()) : null,
      bookId: json['book_id'] != null ? int.tryParse(json['book_id'].toString()) : null,
      createdAt: parseDate(json['created_at']),
      updatedAt: parseDate(json['updated_at']),
      book: BooksModel.fromJson(json['book'] ?? {}),
      category: json['book']?['category'] != null
          ? Category.fromJson(json['book']['category'])
          : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}
