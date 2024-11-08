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



// class HomeModel {
//   HomeModel({
//     required this.id,
//     required this.attributes,
//   });
//   late final int id;
//   late final Attributes attributes;

//   HomeModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     attributes = json['attributes'] == null
//         ? Attributes(
//             Title: '',
//             Slug: '',
//             createdAt: '',
//             publishedAt: '',
//             ViewCount: 0,
//             Content: '',
//             HeadlineImage: HeadlineImageBerita(
//               data: DataHeadlineImage(
//                 id: 0,
//                 attributes: AttributesHeadlineImage(
//                     name: '', url: '', alternativeText: ''),
//               ),
//             ),
//             category: Category(
//               data: DataCategory(
//                 id: 0,
//                 attributesCategory: AttributesCategory(Name: '', Slug: ''),
//               ),
//             ),
//           )
//         : Attributes.fromJson(json['attributes']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['attributes'] = attributes.toJson();
//     return _data;
//   }

//   toList() {}
// }

// class Attributes {
//   Attributes({
//     required this.Title,
//     required this.Slug,
//     required this.createdAt,
//     required this.publishedAt,
//     required this.ViewCount,
//     required this.Content,
//     required this.HeadlineImage,
//     required this.category,
//   });
//   late final String Title;
//   late final String Slug;
//   late final String createdAt;
//   late final String publishedAt;
//   late final int ViewCount;
//   late final String Content;
//   late final HeadlineImageBerita HeadlineImage;
//   late final Category category;

//   Attributes.fromJson(Map<String, dynamic> json) {
//     Title = json['Title'] ?? '';
//     Slug = json['Slug'] ?? '';
//     createdAt = json['createdAt'] ?? '';
//     publishedAt = json['publishedAt'] ?? '';
//     ViewCount = json['ViewCount'] ?? 0;
//     Content = json['Content'] ?? '';
//     HeadlineImage = json['HeadlineImage'] == null
//         ? HeadlineImageBerita(
//             data: DataHeadlineImage(
//               id: 0,
//               attributes: AttributesHeadlineImage(
//                   name: '', url: '', alternativeText: ''),
//             ),
//           )
//         : HeadlineImageBerita.fromJson(json['HeadlineImage']);
//     category = json['category'] == null
//         ? Category(
//             data: DataCategory(
//               id: 0,
//               attributesCategory: AttributesCategory(Name: '', Slug: ''),
//             ),
//           )
//         : Category.fromJson(json['category']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['Title'] = Title;
//     _data['Slug'] = Slug;
//     _data['createdAt'] = createdAt;
//     _data['publishedAt'] = publishedAt;
//     _data['ViewCount'] = ViewCount;
//     _data['Content'] = Content;
//     _data['HeadlineImage'] = HeadlineImage.toJson();
//     _data['category'] = category.toJson();
//     return _data;
//   }
// }

// class HeadlineImageBerita {
//   HeadlineImageBerita({
//     required this.data,
//   });
//   late final DataHeadlineImage data;

//   HeadlineImageBerita.fromJson(Map<String, dynamic> json) {
//     data = json['data'] == null
//         ? DataHeadlineImage(
//             id: 0,
//             attributes:
//                 AttributesHeadlineImage(name: '', url: '', alternativeText: ''),
//           )
//         : DataHeadlineImage.fromJson(json['data']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['data'] = data.toJson();
//     return _data;
//   }
// }

// class DataHeadlineImage {
//   DataHeadlineImage({
//     required this.id,
//     required this.attributes,
//   });
//   late final int id;
//   late final AttributesHeadlineImage attributes;

//   DataHeadlineImage.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     attributes = json['attributes'] == null
//         ? AttributesHeadlineImage(name: '', url: '', alternativeText: '')
//         : AttributesHeadlineImage.fromJson(json['attributes']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['attributes'] = attributes.toJson();
//     return _data;
//   }
// }

// class AttributesHeadlineImage {
//   AttributesHeadlineImage({
//     required this.name,
//     required this.url,
//     required this.alternativeText,
//   });
//   late final String name;
//   late final String url;
//   late final String alternativeText;

//   AttributesHeadlineImage.fromJson(Map<String, dynamic> json) {
//     name = json['name'] ?? '';
//     url = json['url'] ?? '';
//     alternativeText = json['alternativeText'] ?? '';
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['name'] = name;
//     _data['url'] = url;
//     _data['alternativeText'] = alternativeText;
//     return _data;
//   }
// }

// class Category {
//   Category({
//     required this.data,
//   });
//   late final DataCategory data;

//   Category.fromJson(Map<String, dynamic> json) {
//     data = json['data'] == null
//         ? DataCategory(
//             id: 0,
//             attributesCategory: AttributesCategory(Name: '', Slug: ''),
//           )
//         : DataCategory.fromJson(json['data']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['data'] = data.toJson();
//     return _data;
//   }
// }

// class DataCategory {
//   DataCategory({
//     required this.id,
//     required this.attributesCategory,
//   });
//   late final int id;
//   late final AttributesCategory attributesCategory;

//   DataCategory.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     attributesCategory = json['attributes'] == null
//         ? AttributesCategory(Name: '', Slug: '')
//         : AttributesCategory.fromJson(json['attributes']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['attributes'] = attributesCategory.toJson();
//     return _data;
//   }
// }

// class AttributesCategory {
//   AttributesCategory({
//     required this.Name,
//     required this.Slug,
//   });
//   late final String Name;
//   late final String Slug;

//   AttributesCategory.fromJson(Map<String, dynamic> json) {
//     Name = json['Name'] ?? '';
//     Slug = json['Slug'] ?? '';
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['Name'] = Name;
//     _data['Slug'] = Slug;
//     return _data;
//   }
// }
