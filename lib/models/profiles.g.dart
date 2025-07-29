// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profiles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      name: json['name'] as String?,
      avatar: json['avatar'] == null
          ? null
          : Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      email: json['email'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
      'email': instance.email,
      'createdAt': instance.createdAt,
    };
