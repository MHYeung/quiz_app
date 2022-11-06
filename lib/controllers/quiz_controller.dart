import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/model/question/question.dart';
import 'package:quiz_app/model/quiz_state.dart';

final quizControllerProvider =
    StateNotifierProvider.autoDispose<QuizController, QuizState>(
        (ref) => QuizController());

class QuizController extends StateNotifier<QuizState> {
  QuizController() : super(QuizState.initial());

  void submitAnswer(Question currentQuestion, String answer) {
    if (state.answered) return;
    if (currentQuestion.correctAnswer == answer) {
      state = state.copyWith(
        selectedAnswer: answer,
        correct: [currentQuestion, ...state.correct],
        status: QuizStatus.correct,
      );
    } else {
      state = state.copyWith(
        selectedAnswer: answer,
        incorrect: [currentQuestion, ...state.incorrect],
        status: QuizStatus.incorrect,
      );
    }
  }

  void nextQuestion(List<Question> questions, int currentIndex) {
    state = state.copyWith(
      selectedAnswer: '',
      status: currentIndex + 1 < questions.length
          ? QuizStatus.initial
          : QuizStatus.complete,
    );
  }

  void reset() {
    state = QuizState.initial();
  }
}
