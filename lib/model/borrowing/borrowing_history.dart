import 'package:alinea/model/home/home_model.dart';
import 'package:alinea/model/login/user_model.dart';
import 'package:get/get.dart';

class BorrowingHistory {
  final int id;
  final String invoiceId;
  final String userId;
  final String bookId;
  final DateTime borrowDate;
  final DateTime returnDate;
  final String statusId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final BooksModel book;
  final UserModel? user; // Optional user details
  final RxBool isChecked;

  BorrowingHistory({
    required this.id,
    required this.invoiceId,
    required this.userId,
    required this.bookId,
    required this.borrowDate,
    required this.returnDate,
    required this.statusId,
    required this.createdAt,
    required this.updatedAt,
    required this.book,
    this.user,
    bool isChecked = false,
  }) : isChecked = RxBool(isChecked);

  factory BorrowingHistory.fromJson(Map<String, dynamic> json) {
    // Function to safely parse DateTime
    DateTime parseDate(String? date) {
      return DateTime.tryParse(date ?? '') ?? DateTime(1970, 1, 1);
    }

    return BorrowingHistory(
      id: json['id'] ?? 0,
      invoiceId: json['invoice_id'] ?? '',
      userId: json['user_id']?.toString() ?? '',
      bookId: json['book_id']?.toString() ?? '',
      borrowDate: parseDate(json['borrow_date']),
      returnDate: parseDate(json['return_date']),
      statusId: json['status_id'] ?? '',
      createdAt: parseDate(json['created_at']),
      updatedAt: parseDate(json['updated_at']),
      book: BooksModel.fromJson(json['book'] ?? {}),
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}
