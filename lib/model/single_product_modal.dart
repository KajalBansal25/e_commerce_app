import 'package:json_annotation/json_annotation.dart';
part 'single_product_modal.g.dart';

@JsonSerializable()
class ProductModal {
  ProductModal({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  final Rating? rating;

  factory ProductModal.fromJson(Map<String, dynamic> json) =>
      _$ProductModalFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModalToJson(this);
}

@JsonSerializable()
class Rating {
  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}
