import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:quiz_app/controllers/quiz_config_controller.dart';
import 'package:quiz_app/controllers/quiz_controller.dart';
import 'package:quiz_app/global_components/custom_button.dart';
import 'package:quiz_app/model/failure.dart';
import 'package:quiz_app/model/question.dart';
import 'package:quiz_app/model/quiz_state.dart';
import 'package:quiz_app/repository/quiz_repository.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quiz_app/screens/home_screen.dart';
import 'package:quiz_app/screens/quiz_config_screen.dart';

final quizQuestionsProvider = FutureProvider.autoDispose<List<Question>>((ref) {
  final config = ref.watch(quizConfigControllerProvider);
  return ref.watch(quizRepositoryProvider).getQuestions(
      numQuestions: config.numOfQuestions,
      categoryId: config.categoryId + 9,
      difficulty: config.difficulty);
});

class QuizScreen extends HookConsumerWidget {
  const QuizScreen({
    super.key,
  });

  static const routeName = 'quiz';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizQuestions = ref.watch(quizQuestionsProvider);
    final pageController = usePageController();

    return Scaffold(
      body: quizQuestions.when(
          data: (questions) =>
              _buildBody(context, pageController, questions, ref),
          error: (error, _) => QuizError(
                message:
                    error is Failure ? error.message : 'Something went wrong!',
              ),
          loading: () => const Center(child: CircularProgressIndicator())),
      bottomSheet: quizQuestions.maybeWhen(
          data: (questions) {
            final quizState = ref.watch(quizControllerProvider);
            if (!quizState.answered) return const SizedBox.shrink();
            return CustomButton(
              title: pageController.page!.toInt() + 1 < questions.length
                  ? 'Next Question'
                  : 'See Results',
              onTap: () {
                ref
                    .read(quizControllerProvider.notifier)
                    .nextQuestion(questions, pageController.page!.toInt());
                if (pageController.page!.toInt() + 1 < questions.length) {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.linear);
                }
              },
            );
          },
          orElse: () => const SizedBox.shrink()),
    );
  }

  Widget _buildBody(
    BuildContext context,
    PageController pageController,
    List<Question> questions,
    WidgetRef ref,
  ) {
    if (questions.isEmpty) {
      return const QuizError(message: 'No questions found.');
    }

    final quizState = ref.watch(quizControllerProvider.notifier).debugState;
    return quizState.status == QuizStatus.complete
        ? QuizResults(state: quizState, questions: questions)
        : QuizQuestions(
            pageController: pageController,
            state: quizState,
            questions: questions,
            ctx: context,
          );
  }
}

class QuizError extends StatelessWidget {
  const QuizError({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class QuizResults extends HookConsumerWidget {
  const QuizResults({super.key, required this.state, required this.questions});

  final QuizState state;
  final List<Question> questions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${state.correct.length} / ${questions.length}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 60.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'CORRECT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40.0),
        CustomButton(
          title: 'New Quiz',
          onTap: () {
            ref.invalidate(quizRepositoryProvider);
            ref.read(quizControllerProvider.notifier).reset();
            context.goNamed(QuizConfigScreen.routeName);
          },
        ),
        CustomButton(
            title: 'Home Screen',
            onTap: ((() => context.goNamed(HomeScreen.routeName)))),
      ],
    );
  }
}

class QuizQuestions extends HookConsumerWidget {
  final PageController pageController;
  final QuizState state;
  final List<Question> questions;
  final BuildContext ctx;

  const QuizQuestions({
    Key? key,
    required this.pageController,
    required this.state,
    required this.questions,
    required this.ctx
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView.builder(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: questions.length,
      itemBuilder: (BuildContext context, int index) {
        final question = questions[index];
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex:1,child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(color: Colors.white)
                ],
              ),),
              Expanded(
                flex: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Question ${index + 1} of ${questions.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 12.0),
                        child: Text(
                          HtmlCharacterEntities.decode(question.question),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey[200],
                        height: 32.0,
                        thickness: 2.0,
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      Column(
                        children: question.answers
                            .map(
                              (e) => AnswerCard(
                                answer: e,
                                isSelected: e == state.selectedAnswer,
                                isCorrect: e == question.correctAnswer,
                                isDisplayingAnswer: state.answered,
                                onTap: () => ref
                                    .read(quizControllerProvider.notifier)
                                    .submitAnswer(question, e),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isDisplayingAnswer;
  final VoidCallback onTap;

  const AnswerCard({
    Key? key,
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.isDisplayingAnswer,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: boxShadow,
          border: Border.all(
            color: isDisplayingAnswer
                ? isCorrect
                    ? Colors.green
                    : isSelected
                        ? Colors.red
                        : Colors.white
                : Colors.white,
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                HtmlCharacterEntities.decode(answer),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: isDisplayingAnswer && isCorrect
                      ? FontWeight.bold
                      : FontWeight.w400,
                ),
              ),
            ),
            if (isDisplayingAnswer)
              isCorrect
                  ? const CircularIcon(icon: Icons.check, color: Colors.green)
                  : isSelected
                      ? const CircularIcon(
                          icon: Icons.close,
                          color: Colors.red,
                        )
                      : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const CircularIcon({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: boxShadow,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 16.0,
      ),
    );
  }
}
