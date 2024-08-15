class Book_Modele {
  int? id;
  String? title;
  String? category;
  String? author;
  String? description;
  int? rating;
  String? cover;
  String? path;
  int? numberOfPages;
  String? createdAt;
  String? updatedAt;

  Book_Modele(
      {this.id,
        this.title,
        this.category,
        this.author,
        this.description,
        this.rating,
        this.cover,
        this.path,
        this.numberOfPages,
        this.createdAt,
        this.updatedAt});

  Book_Modele.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    author = json['author'];
    description = json['description'];
    rating = json['rating'];
    cover = json['cover'];
    path = json['path'];
    numberOfPages = json['number_of_pages'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['category'] = category;
    data['author'] = author;
    data['description'] = description;
    data['rating'] = rating;
    data['cover'] = cover;
    data['path'] = path;
    data['number_of_pages'] = numberOfPages;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}