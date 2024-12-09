class UserModel {
  final int id;
  final String? image;
  final String nim;
  final String email;
  final String firstName;
  final String lastName;
  final String status;
  final dynamic dueBlock;
  final String role;
  final dynamic noInvoice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String imageUrl;

  UserModel({
    required this.id,
    this.image,
    required this.nim,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.status,
    this.dueBlock,
    required this.role,
    this.noInvoice,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      image: json['image'],
      nim: json['nim'] ?? '',
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      status: json['status'] ?? '',
      dueBlock: json['due_block'],
      role: json['role'] ?? '',
      noInvoice: json['no_invoice'],
      createdAt: DateTime.parse(json['created_at'] ?? '1970-01-01T00:00:00Z'),
      updatedAt: DateTime.parse(json['updated_at'] ?? '1970-01-01T00:00:00Z'),
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'nim': nim,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'status': status,
      'due_block': dueBlock,
      'role': role,
      'no_invoice': noInvoice,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'image_url': imageUrl,
    };
  }
}
