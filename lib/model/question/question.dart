import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question{


  late final Reader _read;

  factory Question({
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'difficulty') String? difficulty,
    @JsonKey(name: 'question') String? question,
    @JsonKey(name: 'correct') String? correctAnswer,
    @Default([]) List<String> answers,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
}

enum Difficulty{
  any,
  easy,
  medium,
  hard
}