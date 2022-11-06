import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/global_components/global_appbar.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  static const routeName = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: GlobalAppBar(title: "Home"),
        body: ElevatedButton(
          onPressed: (() => context.goNamed(QuizScreen.routeName)),
          child: const Text('Start Quiz'),
        ));
  }
}
