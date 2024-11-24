class UserModel {
  final int id;
  final String nim;
  final String email;
  final String firstName;
  final String lastName;
  final String status;
  final String role;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.nim,  
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.status,
    required this.role,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  // Method untuk membuat instance UserModel dari JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nim: json['nim'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      status: json['status'],
      role: json['role'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method untuk mengubah UserModel menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nim': nim,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'status': status,
      'role': role,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
