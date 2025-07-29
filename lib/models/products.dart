import 'package:cybershop/models/review.dart';

import './image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? description;
  int? price;
  double? ratings;
  String? category;
  int? stock;
  int? NoOfReviews;
  String? createdAt;
  List<Image>? images;
  List<Review>? reviews;
  String? time;

  Product({
    this.id,
    this.name,
    this.price,
    this.ratings,
    this.category,
    this.stock,
    this.NoOfReviews,
    this.createdAt,
    this.images,
    this.reviews,
    this.time,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
