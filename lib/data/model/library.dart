import 'package:json_annotation/json_annotation.dart';

part 'library.g.dart';

@JsonSerializable()
class Library extends Child {
  Library(String title, String description, this.author, String? url,
      List<Child>? children)
      : super(title, description, url, children);
  final String author;

  factory Library.fromJson(Map<String, dynamic> json) =>
      _$LibraryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LibraryToJson(this);
}

@JsonSerializable()
class Child {
  Child(this.title, this.description, this.url, this.children);

  final String title;
  final String description;
  final String? url;
  final List<Child>? children;

  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);

  Map<String, dynamic> toJson() => _$ChildToJson(this);
}
