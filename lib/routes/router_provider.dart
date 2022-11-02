import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
            name: HomeScreen.name,
            builder: ((context, state) => const HomeScreen())),
        GoRoute(
            path: '/settings',
            name: SettingScreen.name,
            builder: ((context, state) => const SettingScreen()))
      ];
}
