import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:quiz_app/model/question.dart';

class QuizConfig extends Equatable {
  final int numOfQuestions;
  final int categoryId;
  final bool timerOn;
  final Difficulty difficulty;

  const QuizConfig(
      {required this.numOfQuestions,
      required this.categoryId,
      required this.timerOn,
      required this.difficulty});

  factory QuizConfig.initial() {
    return QuizConfig(
      categoryId: Random().nextInt(24) + 9,
      difficulty: Difficulty.any,
      numOfQuestions: 3,
      timerOn: false,
    );
  }

  QuizConfig copyWith({
    int? numOfQuestions,
    int? categoryId,
    bool? timerOn,
    Difficulty? difficulty,
  }) {
    return QuizConfig(
        numOfQuestions: numOfQuestions ?? this.numOfQuestions,
        categoryId: categoryId ?? this.categoryId,
        timerOn: timerOn ?? this.timerOn,
        difficulty: difficulty ?? this.difficulty);
  }

  @override
  List<Object> get props => [numOfQuestions, categoryId, timerOn, difficulty];
}
