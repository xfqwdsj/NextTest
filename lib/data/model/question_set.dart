import 'package:json_annotation/json_annotation.dart';

part 'question_set.g.dart';

@JsonSerializable()
class QuestionSet {
  QuestionSet(this.version, this.information, this.random, this.questions);

  final int version;
  final Information information;
  final bool random;
  final List<Question> questions;

  factory QuestionSet.fromJson(Map<String, dynamic> json) =>
      _$QuestionSetFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionSetToJson(this);
}

@JsonSerializable()
class Information {
  Information(this.title, this.description, this.version, this.author);

  final String title;
  final String description;
  final String version;
  final String author;

  factory Information.fromJson(Map<String, dynamic> json) =>
      _$InformationFromJson(json);

  Map<String, dynamic> toJson() => _$InformationToJson(this);
}

@JsonSerializable()
class Question {
  Question(this.type, this.question, this.selectionType, this.options,
      this.scoringMode, this.minCorrect, this.blanks);

  final String type;
  final String question;
  final SelectionType? selectionType;
  final List<Option>? options;
  final SelectionScoringMode? scoringMode;
  final int? minCorrect;
  final List<Blank>? blanks;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

enum SelectionType {
  single,
  multiple,
}

@JsonSerializable()
class Option {
  Option(this.title, this.isCorrect, this.score);

  final String title;
  final bool isCorrect;
  final double score;

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}

enum SelectionScoringMode { loose, strict }

@JsonSerializable()
class Blank {
  Blank(this.scoringMode, this.placeholder, this.score, this.answer);

  final FillingScoringMode scoringMode;
  final String placeholder;
  final double score;
  final String answer;

  factory Blank.fromJson(Map<String, dynamic> json) => _$BlankFromJson(json);

  Map<String, dynamic> toJson() => _$BlankToJson(this);
}

enum FillingScoringMode { manual, strict }
