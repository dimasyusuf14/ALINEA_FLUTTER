import 'package:alinea/model/borrowing/borrowing_model.dart';
import 'package:alinea/model/login/user_model.dart';

class InvoiceModel {
  final String id;
  final String userId;
  final String noInvoice;
  final String qrCode;
  final String totalAmount;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<BorrowingModel> borrowings;
  final UserModel user;

  InvoiceModel({
    required this.id,
    required this.userId,
    required this.noInvoice,
    required this.qrCode,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.borrowings,
    required this.user,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      noInvoice: json['no_invoice'] ?? '', // Extract no_invoice
      qrCode: json['qr_code'] ?? '',       // Extract qr_code
      totalAmount: json['total_amount'] ?? '',
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? '1970-01-01'),
      updatedAt: DateTime.parse(json['updated_at'] ?? '1970-01-01'),
      borrowings: (json['borrowings'] as List<dynamic>?)
              ?.map((item) => BorrowingModel.fromJson(item))
              .toList() ??
          [],
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'no_invoice': noInvoice,  // Added to toJson
        'qr_code': qrCode,        // Added to toJson
        'total_amount': totalAmount,
        'status': status,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'borrowings': borrowings.toList(),
        'user': user.toJson(),
      };
}
