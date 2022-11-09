import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/model/question.dart';
import 'package:quiz_app/model/quiz_config.dart';

final quizConfigControllerProvider =
    StateNotifierProvider<QuizConfigController, QuizConfig>(
        (ref) => QuizConfigController());

class QuizConfigController extends StateNotifier<QuizConfig>{
  QuizConfigController() : super(QuizConfig.initial());

  void setConfig({required int number, required int id, required bool timer, required Difficulty diff}){
    state = state.copyWith(
      numOfQuestions: number,
      categoryId: id,
      timerOn: timer,
      difficulty: diff,
    );
    print(state);
  }

void reset() {
    state = QuizConfig.initial();
  }

}