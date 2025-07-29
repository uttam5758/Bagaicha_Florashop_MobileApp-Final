// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      ratings: (json['ratings'] as num?)?.toDouble(),
      category: json['category'] as String?,
      stock: json['stock'] as int?,
      NoOfReviews: json['NoOfReviews'] as int?,
      createdAt: json['createdAt'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      time: json['time'] as String?,
    )..description = json['description'] as String?;

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'ratings': instance.ratings,
      'category': instance.category,
      'stock': instance.stock,
      'NoOfReviews': instance.NoOfReviews,
      'createdAt': instance.createdAt,
      'images': instance.images,
      'reviews': instance.reviews,
      'time': instance.time,
    };
