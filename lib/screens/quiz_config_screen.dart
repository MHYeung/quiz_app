import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/controllers/quiz_config_controller.dart';
import 'package:quiz_app/global_components/custom_button.dart';
import 'package:quiz_app/global_components/title.dart';
import 'package:quiz_app/model/question.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

final numberProvider = StateProvider((ref) => 5);

class QuizConfigScreen extends HookConsumerWidget {
  const QuizConfigScreen({super.key});

  static const routeName = 'quiz-config';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final number = ref.watch(numberProvider);
    final config = ref.watch(quizConfigControllerProvider);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const TitleText(title: 'Configure your quiz'),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            margin: const EdgeInsets.all(4.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Number of Questions: ',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_left,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          if (!(number < 1)) {
                            final num = ref.read(numberProvider.notifier).state--;
                             ref
                                .read(quizConfigControllerProvider.notifier)
                                .setConfig(
                                    number: num-1,
                                    id: config.categoryId,
                                    timer: config.timerOn,
                                    diff: config.difficulty);
                          }
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        // ignore: sort_child_properties_last
                        child: Text(
                          '${number}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.amber)),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_right,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          if (!(number > 20)) {
                            final num = ref.read(numberProvider.notifier).state++;
                            ref
                                .read(quizConfigControllerProvider.notifier)
                                .setConfig(
                                    number: num+1,
                                    id: config.categoryId,
                                    timer: config.timerOn,
                                    diff: config.difficulty);
                          }
                        },
                      ),
                    ],
                  )
                ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            margin: const EdgeInsets.all(4.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Difficulty: ',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  DropdownButton(
                      value: config.difficulty,
                      items: Difficulty.values
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(EnumToString.convertToString(e)
                                    .toUpperCase()),
                              ))
                          .toList(),
                      onChanged: (value) {
                        ref
                            .read(quizConfigControllerProvider.notifier)
                            .setConfig(
                                number: config.numOfQuestions,
                                diff: value!,
                                id: config.categoryId,
                                timer: config.timerOn);
                      }),
                ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            margin: const EdgeInsets.all(4.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Category: ',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  OutlinedButton.icon(
                      onPressed: () {
                        showDialog(
                            useRootNavigator: false,
                            context: context,
                            builder: (context) => Dialog(
                                  child: Wrap(
                                    children: selectCategory
                                        .map((e) => ActionChip(
                                              label: Text(e),
                                              onPressed: () {
                                                final id =
                                                    selectCategory.indexOf(e);

                                                ref
                                                    .read(
                                                        quizConfigControllerProvider
                                                            .notifier)
                                                    .setConfig(
                                                        number: config
                                                            .numOfQuestions,
                                                        id: id,
                                                        timer: config.timerOn,
                                                        diff:
                                                            config.difficulty);
                                                Navigator.of(context).pop();
                                              },
                                            ))
                                        .toList(),
                                  ),
                                ));
                      },
                      icon: const Icon(Icons.menu_book_outlined),
                      label: Text(selectCategory[config.categoryId]))
                ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            margin: const EdgeInsets.all(4.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Timer: ',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16)), //15s per question
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Off'),
                      Switch(
                          value: config.timerOn,
                          onChanged: (value) {
                            ref
                                .read(quizConfigControllerProvider.notifier)
                                .setConfig(
                                    number: config.numOfQuestions,
                                    id: config.categoryId,
                                    timer: value,
                                    diff: config.difficulty);
                          }),
                      const Text('On')
                    ],
                  )
                ]),
          ),
        ],
      )),
      floatingActionButton: CustomButton(
        onTap: (() {
          ref.read(quizConfigControllerProvider.notifier).setConfig(
              number: config.numOfQuestions,
              id: config.categoryId,
              timer: config.timerOn,
              diff: config.difficulty);
          print(config);
          context.goNamed(QuizScreen.routeName);
          ref.read(numberProvider.notifier).state = 5;
        }),
        title: 'Start The Quiz!',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
