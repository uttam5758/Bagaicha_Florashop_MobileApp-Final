import 'package:cybershop/models/products.dart';
import 'package:json_annotation/json_annotation.dart';

part 'productResponse.g.dart';

@JsonSerializable()
class ProductResponse {
  bool? success;
  List<Product>? products;
  ProductResponse({this.success, this.products});
  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return _$ProductResponseFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
