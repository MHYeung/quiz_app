import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/global_components/custom_button.dart';
import 'package:quiz_app/global_components/title.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

import 'home_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  static const routeName = 'settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TitleText(title: 'Settings'),
        ],
      )),
      floatingActionButton: CustomButton(
        onTap: (() => context.goNamed(HomeScreen.routeName)),
        title: 'Back To Home',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
