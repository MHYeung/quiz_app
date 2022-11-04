import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/screens/setting_screen.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  static const name = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
     body: SafeArea(
      minimum: EdgeInsets.all(8.0),
       child: Column(
          children: [
            Center(
              child: Text("Quiz App"),
            ),
            Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){}, child: Text("Start Quiz")),
                    ElevatedButton(onPressed: ()=> context.pushNamed(SettingScreen.name), child: Text("Setting"))
                  ],
                ))
          ],
        ),
     ),
    );
  }
}

