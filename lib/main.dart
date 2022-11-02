import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/routes/router_provider.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: RootApp()));
}

class RootApp extends HookConsumerWidget {
  const RootApp({super.key});

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final router = ref.watch(routerProvider);
    return MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      title: 'Training App Combined',
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
    );
  }
}