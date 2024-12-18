import 'package:alinea/model/home/home_model.dart';

class NotificationsModel {
  final int id;
  final String userId;
  final String message;
  final bool isRead;
  final String? adminId;
  final String? bookId;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BooksModel book; 

  NotificationsModel({
    required this.id,
    required this.userId,
    required this.message,
    required this.isRead,
    this.adminId,
    this.bookId,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.book
  });

  NotificationsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        userId = json['user_id'] ?? '',
        message = json['message'] ?? '',
        isRead = (json['is_read'] ?? '0') == '1',
        adminId = json['admin_id']?.toString(), // Nullable field
        bookId = json['book_id']?.toString(), // Nullable field
        type = json['type'] ?? '',
        createdAt = DateTime.parse(json['created_at'] ?? '1970-01-01'),
        updatedAt = DateTime.parse(json['updated_at'] ?? '1970-01-01'),
        // updatedAt = DateTime.parse(json['updated_at'] ?? '1970-01-01');
        book = BooksModel.fromJson(json['book']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'message': message,
        'is_read': isRead ? '1' : '0', // Convert boolean back to "0" or "1"
        'admin_id': adminId,
        'book_id': bookId,
        'type': type,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'book': book.toJson()
      };
}
