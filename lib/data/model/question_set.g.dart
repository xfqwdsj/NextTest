// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionSet _$QuestionSetFromJson(Map<String, dynamic> json) => QuestionSet(
      json['version'] as String,
      Information.fromJson(json['information'] as Map<String, dynamic>),
      json['random'] as bool,
      (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionSetToJson(QuestionSet instance) =>
    <String, dynamic>{
      'version': instance.version,
      'information': instance.information,
      'random': instance.random,
      'questions': instance.questions,
    };

Information _$InformationFromJson(Map<String, dynamic> json) => Information(
      json['title'] as String,
      json['description'] as String,
      json['version'] as String,
      json['author'] as String,
    );

Map<String, dynamic> _$InformationToJson(Information instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'version': instance.version,
      'author': instance.author,
    };

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
  $enumDecode(_$QuestionTypeEnumMap, json['type']),
      json['question'] as String,
      $enumDecodeNullable(_$SelectionTypeEnumMap, json['selectionType']),
      (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      $enumDecodeNullable(_$SelectionScoringModeEnumMap, json['scoringMode']),
      json['minCorrect'] as int?,
      (json['blanks'] as List<dynamic>?)
          ?.map((e) => Blank.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'type': _$QuestionTypeEnumMap[instance.type]!,
      'question': instance.question,
      'selectionType': _$SelectionTypeEnumMap[instance.selectionType],
      'options': instance.options,
      'scoringMode': _$SelectionScoringModeEnumMap[instance.scoringMode],
      'minCorrect': instance.minCorrect,
      'blanks': instance.blanks,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.selection: 'selection',
  QuestionType.filling: 'filling',
};

const _$SelectionTypeEnumMap = {
  SelectionType.single: 'single',
  SelectionType.multiple: 'multiple',
};

const _$SelectionScoringModeEnumMap = {
  SelectionScoringMode.loose: 'loose',
  SelectionScoringMode.strict: 'strict',
};

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      json['title'] as String,
      json['isCorrect'] as bool,
      (json['score'] as num).toDouble(),
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'title': instance.title,
      'isCorrect': instance.isCorrect,
      'score': instance.score,
    };

Blank _$BlankFromJson(Map<String, dynamic> json) => Blank(
      $enumDecode(_$FillingScoringModeEnumMap, json['scoringMode']),
      json['placeholder'] as String,
      (json['score'] as num).toDouble(),
      json['answer'] as String,
    );

Map<String, dynamic> _$BlankToJson(Blank instance) => <String, dynamic>{
      'scoringMode': _$FillingScoringModeEnumMap[instance.scoringMode]!,
      'placeholder': instance.placeholder,
      'score': instance.score,
      'answer': instance.answer,
    };

const _$FillingScoringModeEnumMap = {
  FillingScoringMode.manual: 'manual',
  FillingScoringMode.strict: 'strict',
};
