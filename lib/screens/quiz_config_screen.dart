import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/controllers/quiz_config_controller.dart';
import 'package:quiz_app/global_components/custom_button.dart';
import 'package:quiz_app/global_components/title.dart';
import 'package:quiz_app/model/question.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

//TODO: TIMER OPTION, DIFFICULTY, CATEGORY

class QuizConfigScreen extends HookConsumerWidget {
  const QuizConfigScreen({super.key});

  static const routeName = 'quiz-config';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const TitleText(title: 'Configure your quiz'),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            margin: EdgeInsets.all(4.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Number of Questions: ',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_left,
                          color: Colors.amber,
                        ),
                        onPressed: () {},
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '5',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.amber)),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_right,
                          color: Colors.amber,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  )
                ]),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            margin: EdgeInsets.all(4.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Difficulty: ',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  )
                ]),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            margin: EdgeInsets.all(4.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Category: ',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  )
                ]),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            margin: EdgeInsets.all(4.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Timer: ',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16)), //15s per question
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Off'),
                      Switch(value: false, onChanged: (value) {}),
                      Text('On')
                    ],
                  )
                ]),
          ),
        ],
      )),
      floatingActionButton: CustomButton(
        onTap: (() {
          ref.read(quizConfigControllerProvider.notifier).setConfig(
              number: 5, id: 15, timer: false, diff: Difficulty.easy);
          context.goNamed(QuizScreen.routeName);
        }),
        title: 'Start The Quiz!',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
