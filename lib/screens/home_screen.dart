import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/global_components/custom_button.dart';
import 'package:quiz_app/global_components/global_appbar.dart';
import 'package:quiz_app/screens/past_record_screen.dart';
import 'package:quiz_app/screens/quiz_config_screen.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/screens/setting_screen.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  static const routeName = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomButton(
          onTap: (() => context.goNamed(QuizConfigScreen.routeName)),
          title: 'Start Quiz',
        ),
        CustomButton(
            title: 'Past Records',
            onTap: (() => context.pushNamed(PastRecordScreen.routeName))),
        CustomButton(
            title: 'Settings',
            onTap: (() => context.pushNamed(SettingScreen.routeName)))
      ],
    ));
  }
}
