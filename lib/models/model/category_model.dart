class CategoryModel {
  final String? title;
  final int id;
  final String? image;
  final String? description;
  final Rate? rating;

  CategoryModel({
    this.title,
    required this.id,
    this.image,
    this.description,
    this.rating,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      title: json['title'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      rating: json['rating'] != null ? Rate.fromJson(json['rating']) : null,
    );
  }
}

class Rate {
  final double? rate;
  final int? count;

  Rate({this.rate, this.count});

  factory Rate.fromJson(Map<String, dynamic> json) {
    return Rate(
      rate: (json['rate'] as num?)?.toDouble(),
      count: json['count'] as int?,
    );
  }
}
