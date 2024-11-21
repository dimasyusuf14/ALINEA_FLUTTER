import 'package:alinea/models/home/home_model.dart';
import 'package:alinea/models/login/user_model.dart';
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
    return CartModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] != null ? int.tryParse(json['user_id'].toString()) : null,
      bookId: json['book_id'] != null ? int.tryParse(json['book_id'].toString()) : null,
      createdAt: DateTime.parse(json['created_at'] ?? '1970-01-01'),
      updatedAt: DateTime.parse(json['updated_at'] ?? '1970-01-01'),
      book: BooksModel.fromJson(json['book'] ?? {}),
      category: json['book']?['category'] != null
          ? Category.fromJson(json['book']['category'])
          : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}
