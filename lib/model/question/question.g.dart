// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Question _$$_QuestionFromJson(Map<String, dynamic> json) => _$_Question(
      category: json['category'] as String?,
      difficulty: json['difficulty'] as String?,
      question: json['question'] as String?,
      correctAnswer: json['correct'] as String?,
      answers: (json['answers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_QuestionToJson(_$_Question instance) =>
    <String, dynamic>{
      'category': instance.category,
      'difficulty': instance.difficulty,
      'question': instance.question,
      'correct': instance.correctAnswer,
      'answers': instance.answers,
    };
