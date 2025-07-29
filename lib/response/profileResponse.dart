import 'package:json_annotation/json_annotation.dart';

import '../models/profiles.dart';


part 'profileResponse.g.dart';

@JsonSerializable()
class ProfileResponse {
  bool? success;

  Profile? user;

  ProfileResponse({this.success, this.user});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
