import 'package:json_annotation/json_annotation.dart';

part 'libraries.g.dart';

@JsonSerializable()
class Libraries {
  Libraries(this.urls);

  final List<String> urls;

  factory Libraries.fromJson(Map<String, dynamic> json) =>
      _$LibrariesFromJson(json);

  Map<String, dynamic> toJson() => _$LibrariesToJson(this);
}
