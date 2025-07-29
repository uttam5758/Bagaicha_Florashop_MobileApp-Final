import 'package:json_annotation/json_annotation.dart';

part 'avatar.g.dart';

@JsonSerializable()
class Avatar {
  String? url;

  Avatar({this.url});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return _$AvatarFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}
