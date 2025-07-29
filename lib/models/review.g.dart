// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      user: json['user'] as String?,
      name: json['name'] as String?,
      rating: json['rating'] as int?,
      comment: json['comment'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'user': instance.user,
      'name': instance.name,
      'rating': instance.rating,
      'comment': instance.comment,
      'time': instance.time,
    };
