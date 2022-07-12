// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Library _$LibraryFromJson(Map<String, dynamic> json) => Library(
      json['title'] as String,
      json['description'] as String,
      json['author'] as String,
      (json['children'] as List<dynamic>)
          .map((e) => Child.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LibraryToJson(Library instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'author': instance.author,
      'children': instance.children,
    };

Child _$ChildFromJson(Map<String, dynamic> json) => Child(
      json['title'] as String,
      json['description'] as String,
      json['url'] as String,
      (json['children'] as List<dynamic>)
          .map((e) => Child.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'children': instance.children,
    };
