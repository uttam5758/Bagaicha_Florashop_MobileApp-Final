import 'package:json_annotation/json_annotation.dart';

part 'userModel.g.dart';

@JsonSerializable()
class User {
  String? name;
  String? email;
  String? password;

  User({this.name, this.email, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
