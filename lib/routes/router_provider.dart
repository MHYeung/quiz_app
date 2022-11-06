import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/model/question.dart';
import 'package:quiz_app/screens/past_record_screen.dart';
import 'package:quiz_app/screens/quiz_config_screen.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

import '../screens/home_screen.dart';
import '../screens/setting_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);
  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: router,
    routes: router._routes,
    initialLocation: '/',
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref);

  List<GoRoute> get _routes => [
        GoRoute(
            path: '/',
            name: HomeScreen.routeName,
            builder: (context, state) => const HomeScreen()),
        GoRoute(
            path: '/past-record',
            name: PastRecordScreen.routeName,
            builder: (context, state) => const PastRecordScreen()),
        GoRoute(
            path: '/settings',
            name: SettingScreen.routeName,
            builder: (context, state) => const SettingScreen()),
        GoRoute(
          path: '/quiz-config',
          name: QuizConfigScreen.routeName,
          builder: (context, state) => const QuizConfigScreen(),
        ),
        GoRoute(
          path: '/quiz/:number/:catId/:difficulty',
          name: QuizScreen.routeName,
          builder: (context, state) {
            int number = int.parse(state.params['number']!);
            int catId = int.parse(state.params['catId']!);
            Difficulty difficulty = Difficulty.values[int.parse(state.params['difficulty']!)];
            return QuizScreen(number: number, catId: catId, diff: difficulty);
          },
        )
      ];
}
