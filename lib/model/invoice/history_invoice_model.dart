class HistoryInvoiceModel {
  late final int id;
  late final int noInvoice;
  late final String qrCode;
  late final int userId;
  late final String totalAmount;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  late final List<Borrowings> borrowings;
  late final User user;

  HistoryInvoiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    noInvoice = int.tryParse(json['no_invoice'] ?? '') ?? 0;
    qrCode = json['qr_code'] ?? '';
    userId = int.tryParse(json['user_id'] ?? '') ?? 0;
    totalAmount = json['total_amount'] ?? '';
    status = json['status'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    borrowings = (json['borrowings'] as List? ?? [])
        .map((e) => Borrowings.fromJson(e))
        .toList();
    user = User.fromJson(json['user'] ?? {});
  }
}

class Borrowings {
  late final int id;
  late final int invoiceId;
  late final int userId;
  late final int bookId;
  late final String borrowDate;
  late final String returnDate;
  late final int statusId;
  late final String createdAt;
  late final String updatedAt;
  late final Book book;

  Borrowings.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    invoiceId = int.tryParse(json['invoice_id'] ?? '') ?? 0;
    userId = int.tryParse(json['user_id'] ?? '') ?? 0;
    bookId = int.tryParse(json['book_id'] ?? '') ?? 0;
    borrowDate = json['borrow_date'] ?? '';
    returnDate = json['return_date'] ?? '';
    statusId = int.tryParse(json['status_id'] ?? '') ?? 0;
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    book = Book.fromJson(json['book'] ?? {});
  }
}

class Book {
  late final int id;
  late final String cover;
  late final String title;
  late final String author;
  late final String isbn;
  late final int stock;
  late final String description;
  late final String publishedDate;
  late final String status;
  late final int categoryId;
  late final String createdAt;
  late final String updatedAt;
  late final String coverUrl;
  late final Category category;

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    cover = json['cover'] ?? '';
    title = json['title'] ?? '';
    author = json['author'] ?? '';
    isbn = json['isbn'] ?? '';
    stock = int.tryParse(json['stock'] ?? '') ?? 0;
    description = json['description'] ?? '';
    publishedDate = json['published_date'] ?? '';
    status = json['status'] ?? '';
    categoryId = int.tryParse(json['category_id'] ?? '') ?? 0;
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    coverUrl = json['cover_url'] ?? '';
    category = Category.fromJson(json['category'] ?? {});
  }
}

class Category {
  late final int id;
  late final String name;
  late final String description;
  late final String createdAt;
  late final String updatedAt;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    description = json['description'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class User {
  late final int id;
  late final String? image;
  late final String nim;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final int status;
  late final String? dueBlock;
  late final String role;
  late final String? noInvoice;
  late final String createdAt;
  late final String updatedAt;
  late final String imageUrl;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    image = json['image'] ?? '';
    nim = json['nim'] ?? '';
    email = json['email'] ?? '';
    firstName = json['first_name'] ?? '';
    lastName = json['last_name'] ?? '';
    status = int.tryParse(json['status'] ?? '') ?? 0;
    dueBlock = json['due_block'] ?? '';
    role = json['role'] ?? '';
    noInvoice = json['no_invoice'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    imageUrl = json['image_url'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['nim'] = nim;
    _data['email'] = email;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['status'] = status;
    _data['due_block'] = dueBlock;
    _data['role'] = role;
    _data['no_invoice'] = noInvoice;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['image_url'] = imageUrl;
    return _data;
  }
}
