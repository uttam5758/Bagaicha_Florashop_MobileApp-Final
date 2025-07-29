import 'package:cybershop/models/avatar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profiles.g.dart';

@JsonSerializable()
class Profile {
  String? name;
  Avatar? avatar;
  String? email;
  String? createdAt;
  Profile({this.name, this.avatar, this.email, this.createdAt});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return _$ProfileFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
