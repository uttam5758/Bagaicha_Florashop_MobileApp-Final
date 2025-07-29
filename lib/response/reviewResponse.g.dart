// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviewResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewResponse _$ReviewResponseFromJson(Map<String, dynamic> json) =>
    ReviewResponse(
      success: json['success'] as bool?,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewResponseToJson(ReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'reviews': instance.reviews,
    };
