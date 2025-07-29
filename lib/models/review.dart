import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  String? user;

  String? name;

  int? rating;

  String? comment;

  String? time;

  Review({this.user, this.name, this.rating, this.comment, this.time});

  factory Review.fromJson(Map<String, dynamic> json) {
    return _$ReviewFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
