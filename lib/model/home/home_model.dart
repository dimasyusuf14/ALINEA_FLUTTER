class BooksModel {
  final int id;
  final String cover;
  final String title;
  final String author;
  final String isbn;
  final int stock;
  final String description;
  final DateTime publishedDate;
  final String status;
  final String categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String coverUrl;

  BooksModel({
    required this.id,
    required this.cover,
    required this.title,
    required this.author,
    required this.isbn,
    required this.stock,
    required this.description,
    required this.publishedDate,
    required this.status,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.coverUrl,
  });

  // /// Tambahkan metode empty untuk mengembalikan object kosong
  // factory BooksModel.empty() {
  //   return BooksModel(
  //     id: 0,
  //     cover: '',
  //     title: '',
  //     author: '',
  //     isbn: '',
  //     stock: 0,
  //     description: '',
  //     publishedDate: DateTime(1970, 1, 1),
  //     status: '',
  //     categoryId: '',
  //     createdAt: DateTime(1970, 1, 1),
  //     updatedAt: DateTime(1970, 1, 1),
  //     coverUrl: '',
  //   );
  // }

  BooksModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        cover = json['cover'] ?? '',
        title = json['title'] ?? '',
        author = json['author'] ?? '',
        isbn = json['isbn'] ?? '',
        stock = int.tryParse(json['stock']?.toString() ?? '0') ?? 0,
        description = json['description'] ?? '',
        publishedDate = DateTime.tryParse(json['published_date'] ?? '1970-01-01') ?? DateTime(1970, 1, 1),
        status = json['status'] ?? '',
        categoryId = json['category_id']?.toString() ?? '',
        createdAt = DateTime.tryParse(json['created_at'] ?? '1970-01-01') ?? DateTime(1970, 1, 1),
        updatedAt = DateTime.tryParse(json['updated_at'] ?? '1970-01-01') ?? DateTime(1970, 1, 1),
        coverUrl = json['cover_url'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'cover': cover,
        'title': title,
        'author': author,
        'isbn': isbn,
        'stock': stock.toString(),
        'description': description,
        'published_date': publishedDate.toIso8601String(),
        'status': status,
        'category_id': categoryId,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'cover_url': coverUrl,
      };
}


class Category {
  final int id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? '1970-01-01'),
      updatedAt: DateTime.parse(json['updated_at'] ?? '1970-01-01'),
    );
  }
}
