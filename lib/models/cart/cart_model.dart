import 'package:alinea/models/home/home_model.dart';
import 'package:alinea/models/login/user_model.dart';

class CartModel {
  final int id;
  final int userId;
  final int bookId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BooksModel book;
  final Category category;
  final UserModel user;
  bool isChecked; // New property to track checkbox status

  CartModel({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.createdAt,
    required this.updatedAt,
    required this.book,
    required this.category,
    required this.user,
    this.isChecked = false, // Default unchecked
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      bookId: json['book_id'] ?? 0,
      createdAt: DateTime.parse(json['created_at'] ?? '1970-01-01'),
      updatedAt: DateTime.parse(json['updated_at'] ?? '1970-01-01'),
      book: BooksModel.fromJson(json['book'] ?? {}),
      category: Category.fromJson(json['name'] ?? {}),
      user: UserModel.fromJson(json['id']??''),
    );
  }
}

// class BooksModel {
//   final int id;
//   final String cover;
//   final String title;
//   final String author;
//   final String isbn;
//   final int stock;
//   final String description;
//   final DateTime publishedDate;
//   final String status;
//   final String categoryId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final String coverUrl;
//   final Category category;

//   BooksModel({
//     required this.id,
//     required this.cover,
//     required this.title,
//     required this.author,
//     required this.isbn,
//     required this.stock,
//     required this.description,
//     required this.publishedDate,
//     required this.status,
//     required this.categoryId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.coverUrl,
//     required this.category,
//   });

//   factory BooksModel.fromJson(Map<String, dynamic> json) {
//     return BooksModel(
//       id: json['id'] ?? 0,
//       cover: json['cover'] ?? '',
//       title: json['title'] ?? '',
//       author: json['author'] ?? '',
//       isbn: json['isbn'] ?? '',
//       stock: json['stock'] ?? 0,
//       description: json['description'] ?? '',
//       publishedDate: DateTime.parse(json['published_date'] ?? '1970-01-01'),
//       status: json['status'] ?? '',
//       categoryId: json['category_id'] ?? 0,
//       createdAt: DateTime.parse(json['created_at'] ?? '1970-01-01'),
//       updatedAt: DateTime.parse(json['updated_at'] ?? '1970-01-01'),
//       coverUrl: json['cover_url'] ?? '',
//       category: Category.fromJson(json['category'] ?? {}),
//     );
//   }
// }

// class Category {
//   final int id;
//   final String name;
//   final String description;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Category({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//       description: json['description'] ?? '',
//       createdAt: DateTime.parse(json['created_at'] ?? '1970-01-01'),
//       updatedAt: DateTime.parse(json['updated_at'] ?? '1970-01-01'),
//     );
//   }
// }
