class DetailHomeModel {
  DetailHomeModel({
    required this.id,
    required this.attributes,
  });
  late final int id;
  late final Attributes attributes;

  DetailHomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] == null
        ? Attributes(
            Title: '',
            Content: '',
            Slug: '',
            Headline: true,
            YoutubeURL: '',
            createdAt: '',
            updatedAt: '',
            publishedAt: '',
            ViewCount: 0,
            Date: '',
            SpotifyURL: '',
            HeadlineVideo: true,
            category: Category(
                data: DataCategory(
                    id: 0,
                    attributes: AttributesCategory(
                        Name: '',
                        createdAt: '',
                        updatedAt: '',
                        Slug: '',
                        parentCategory: ParentCategory(
                            data: DataParent(
                                id: 0,
                                attributes: AttributesParent(
                                    Name: '',
                                    createdAt: '',
                                    updatedAt: '',
                                    Slug: '')))))),
            createdBy: CreatedBy(
                data: DataCreated(
                    id: 0,
                    attributes:
                        AttributesCreated(firstname: '', lastname: ''))),
            updatedBy: UpdatedBy(
                data: DataUpadted(
                    id: 0,
                    attributes:
                        AttributesUpdated(firstname: '', lastname: ''))))
        : Attributes.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes.toJson();
    return _data;
  }
}

class Attributes {
  Attributes({
    required this.Title,
    required this.Content,
    required this.Date,
    required this.Slug,
    required this.Headline,
    required this.YoutubeURL,
    required this.SpotifyURL,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.ViewCount,
    required this.HeadlineVideo,
    required this.category,
    required this.createdBy,
    required this.updatedBy,
  });
  late final String Title;
  late final String Content;
  late final String Date;
  late final String Slug;
  late final bool Headline;
  late final String YoutubeURL;
  late final String SpotifyURL;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;
  late final int ViewCount;
  late final bool HeadlineVideo;
  late final Category category;
  late final CreatedBy createdBy;
  late final UpdatedBy updatedBy;

  Attributes.fromJson(Map<String, dynamic> json) {
    Title = json['Title'] ?? '';
    Content = json['Content'] ?? '';
    Date = json['Date'] ?? '';
    Slug = json['Slug'] ?? '';
    Headline = json['Headline'] ?? '';
    YoutubeURL = json['YoutubeURL'] ?? '';
    SpotifyURL = json['SpotifyURL'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    publishedAt = json['publishedAt'] ?? '';
    ViewCount = json['ViewCount'] ?? '';
    HeadlineVideo = json['HeadlineVideo'] ?? '';
    category = Category.fromJson(json['category'] ?? '');
    createdBy = CreatedBy.fromJson(json['createdBy'] ?? '');
    updatedBy = UpdatedBy.fromJson(json['updatedBy'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Title'] = Title;
    _data['Content'] = Content;
    _data['Date'] = Date;
    _data['Slug'] = Slug;
    _data['Headline'] = Headline;
    _data['YoutubeURL'] = YoutubeURL;
    _data['SpotifyURL'] = SpotifyURL;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    _data['ViewCount'] = ViewCount;
    _data['HeadlineVideo'] = HeadlineVideo;
    _data['category'] = category.toJson();
    _data['createdBy'] = createdBy.toJson();
    _data['updatedBy'] = updatedBy.toJson();
    return _data;
  }
}

class Category {
  Category({
    required this.data,
  });
  late final DataCategory data;

  Category.fromJson(Map<String, dynamic> json) {
    data = json['data'] == null
        ? DataCategory(
            id: 0,
            attributes: AttributesCategory(
                Name: '',
                createdAt: '',
                updatedAt: '',
                Slug: '',
                parentCategory: ParentCategory(
                    data: DataParent(
                        id: 0,
                        attributes: AttributesParent(
                            Name: '',
                            createdAt: '',
                            updatedAt: '',
                            Slug: '')))))
        : DataCategory.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class DataCategory {
  DataCategory({
    required this.id,
    required this.attributes,
  });
  late final int id;
  late final AttributesCategory attributes;

  DataCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] == null
        ? AttributesCategory(
            Name: '',
            createdAt: '',
            updatedAt: '',
            Slug: '',
            parentCategory: ParentCategory(
                data: DataParent(
                    id: 0,
                    attributes: AttributesParent(
                        Name: '', createdAt: '', updatedAt: '', Slug: ''))))
        : AttributesCategory.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes.toJson();
    return _data;
  }
}

class AttributesCategory {
  AttributesCategory({
    required this.Name,
    required this.createdAt,
    required this.updatedAt,
    required this.Slug,
    required this.parentCategory,
  });
  late final String Name;
  late final String createdAt;
  late final String updatedAt;
  late final String Slug;
  late final ParentCategory parentCategory;

  AttributesCategory.fromJson(Map<String, dynamic> json) {
    Name = json['Name'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    Slug = json['Slug'] ?? '';
    parentCategory = ParentCategory.fromJson(json['parent_category'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Name'] = Name;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['Slug'] = Slug;
    _data['parent_category'] = parentCategory.toJson();
    return _data;
  }
}

class ParentCategory {
  ParentCategory({
    required this.data,
  });
  late final DataParent data;

  ParentCategory.fromJson(Map<String, dynamic> json) {
    data = json['data'] == null
        ? DataParent(
            id: 0,
            attributes: AttributesParent(
                Name: '', createdAt: '', updatedAt: '', Slug: ''))
        : DataParent.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class DataParent {
  DataParent({
    required this.id,
    required this.attributes,
  });
  late final int id;
  late final AttributesParent attributes;

  DataParent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = AttributesParent.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes.toJson();
    return _data;
  }
}

class AttributesParent {
  AttributesParent({
    required this.Name,
    required this.createdAt,
    required this.updatedAt,
    required this.Slug,
  });
  late final String Name;
  late final String createdAt;
  late final String updatedAt;
  late final String Slug;

  AttributesParent.fromJson(Map<String, dynamic> json) {
    Name = json['Name'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    Slug = json['Slug'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Name'] = Name;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['Slug'] = Slug;
    return _data;
  }
}

class CreatedBy {
  CreatedBy({
    required this.data,
  });
  late final DataCreated data;

  CreatedBy.fromJson(Map<String, dynamic> json) {
    data = DataCreated.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class DataCreated {
  DataCreated({
    required this.id,
    required this.attributes,
  });
  late final int id;
  late final AttributesCreated attributes;

  DataCreated.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = AttributesCreated.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes.toJson();
    return _data;
  }
}

class AttributesCreated {
  AttributesCreated({
    required this.firstname,
    required this.lastname,
  });
  late final String firstname;
  late final String lastname;

  AttributesCreated.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'] ?? '';
    lastname = json['lastname'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    return _data;
  }
}

class UpdatedBy {
  UpdatedBy({
    required this.data,
  });
  late final DataUpadted data;

  UpdatedBy.fromJson(Map<String, dynamic> json) {
    data = DataUpadted.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class DataUpadted {
  DataUpadted({
    required this.id,
    required this.attributes,
  });
  late final int id;
  late final AttributesUpdated attributes;

  DataUpadted.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = AttributesUpdated.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes.toJson();
    return _data;
  }
}

class AttributesUpdated {
  AttributesUpdated({
    required this.firstname,
    required this.lastname,
  });
  late final String firstname;
  late final String lastname;

  AttributesUpdated.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'] ?? '';
    lastname = json['lastname'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    return _data;
  }
}
