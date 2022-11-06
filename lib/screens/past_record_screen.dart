import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/global_components/custom_button.dart';
import 'package:quiz_app/global_components/title.dart';
import 'package:quiz_app/screens/home_screen.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

class PastRecordScreen extends HookConsumerWidget {
  const PastRecordScreen({super.key});

  static const routeName = 'past-record';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(flex: 1, child: Center(child: TitleText(title: 'Past Records'))),
          const Divider(),
          Expanded(flex: 10,
            child: ListView.builder(itemCount: 10,itemBuilder: ((context, index) {
              return ListTile(
                title: Text('$index'),
              );
            })),
          )
        ],
      )),
      floatingActionButton: CustomButton(onTap: (() => context.goNamed(HomeScreen.routeName)), title: 'Back to Home',),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
