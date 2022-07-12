import 'package:json_annotation/json_annotation.dart';

part 'library.g.dart';

@JsonSerializable()
class Library {
  Library(this.title, this.description, this.author, this.children);

  final String title;
  final String description;
  final String author;
  final List<Child> children;

  factory Library.fromJson(Map<String, dynamic> json) =>
      _$LibraryFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryToJson(this);
}

@JsonSerializable()
class Child {
  Child(this.title, this.description, this.url, this.children);

  final String title;
  final String description;
  final String url;
  final List<Child> children;

  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);

  Map<String, dynamic> toJson() => _$ChildToJson(this);
}
