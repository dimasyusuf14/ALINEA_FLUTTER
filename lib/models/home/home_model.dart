class BooksModel {
  final int id;
  final String cover;
  final String title;
  final String author;
  final String isbn;
  final String stock;
  final String description;
  final DateTime publishedDate;
  final String status;
  final String categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String coverUrl; // New field

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
    required this.coverUrl, // New field in constructor
  });

  // Deserialization from JSON
  BooksModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        cover = json['cover'] ?? '',
        title = json['title'] ?? '',
        author = json['author'] ?? '',
        isbn = json['isbn'] ?? '',
        stock = json['stock'] ?? '',
        description = json['description'] ?? '',
        publishedDate = DateTime.parse(json['published_date'] ?? '1970-01-01'),
        status = json['status'] ?? '',
        categoryId = json['category_id'] ?? '',
        createdAt = DateTime.parse(json['created_at'] ?? '1970-01-01'),
        updatedAt = DateTime.parse(json['updated_at'] ?? '1970-01-01'),
        coverUrl = json['cover_url'] ?? ''; // New field in deserialization

  // Serialization to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'cover': cover,
        'title': title,
        'author': author,
        'isbn': isbn,
        'stock': stock,
        'description': description,
        'published_date': publishedDate.toIso8601String(),
        'status': status,
        'category_id': categoryId,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'cover_url': coverUrl, // New field in serialization
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
      id: json['id'] ?? '',
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
