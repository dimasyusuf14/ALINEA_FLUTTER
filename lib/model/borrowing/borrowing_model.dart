import 'package:get/get.dart';
import 'package:alinea/model/home/home_model.dart';
import 'package:alinea/model/login/user_model.dart';

class BorrowingModel {
  final int id;
  final String? invoiceId; // Allow null
  final int? userId; // Allow null
  final int? bookId; // Allow null
  final DateTime borrowDate;
  final DateTime returnDate;
  final String? statusId; // Allow null
  final DateTime createdAt;
  final DateTime updatedAt;
  final BooksModel book;
  final UserModel? user; // Allow null
  final Status? status; // Allow null
  final Invoice? invoice; // Allow null
  final RxBool isChecked;

  BorrowingModel({
    required this.id,
    this.invoiceId,
    this.userId,
    this.bookId,
    required this.borrowDate,
    required this.returnDate,
    this.statusId,
    required this.createdAt,
    required this.updatedAt,
    required this.book,
    this.user,
    this.status,
    this.invoice,
    bool isChecked = false,
  }) : isChecked = RxBool(isChecked);

  factory BorrowingModel.fromJson(Map<String, dynamic> json) {
    // Fungsi untuk parsing tanggal dengan aman
    DateTime parseDate(String? date) {
      return DateTime.tryParse(date ?? '') ?? DateTime(1970, 1, 1);
    }

    return BorrowingModel(
      id: json['id'] ?? 0,
      invoiceId: json['invoice_id'] as String?,
      userId: json['user_id'] != null ? int.tryParse(json['user_id'].toString()) : null,
      bookId: json['book_id'] != null ? int.tryParse(json['book_id'].toString()) : null,
      borrowDate: parseDate(json['borrow_date']),
      returnDate: parseDate(json['return_date']),
      statusId: json['status_id'] as String?,
      createdAt: parseDate(json['created_at']),
      updatedAt: parseDate(json['updated_at']),
      book: BooksModel.fromJson(json['book'] ?? {}),
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      invoice: json['invoice'] != null ? Invoice.fromJson(json['invoice']) : null,
    );
  }
}

class Status {
  final int id;
  final String name;
  final String? color; // Allow null
  final String? message; // Allow null
  final String? description; // Allow null
  final DateTime createdAt;
  final DateTime updatedAt;

  Status({
    required this.id,
    required this.name,
    this.color,
    this.message,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    DateTime parseDate(String? date) {
      return DateTime.tryParse(date ?? '') ?? DateTime(1970, 1, 1);
    }

    return Status(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      color: json['color'] as String?,
      message: json['message'] as String?,
      description: json['description'] as String?,
      createdAt: parseDate(json['created_at']),
      updatedAt: parseDate(json['updated_at']),
    );
  }
}

class Invoice {
  final int id;
  final String noInvoice;
  final String? qrCode; // Allow null
  final int? userId; // Allow null
  final String? totalAmount; // Allow null
  final String? status; // Allow null
  final DateTime createdAt;
  final DateTime updatedAt;

  Invoice({
    required this.id,
    required this.noInvoice,
    this.qrCode,
    this.userId,
    this.totalAmount,
    this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    DateTime parseDate(String? date) {
      return DateTime.tryParse(date ?? '') ?? DateTime(1970, 1, 1);
    }

    return Invoice(
      id: json['id'] ?? 0,
      noInvoice: json['no_invoice'] ?? '',
      qrCode: json['qr_code'] as String?,
      userId: json['user_id'] != null ? int.tryParse(json['user_id'].toString()) : null,
      totalAmount: json['total_amount'] as String?,
      status: json['status'] as String?,
      createdAt: parseDate(json['created_at']),
      updatedAt: parseDate(json['updated_at']),
    );
  }
}
