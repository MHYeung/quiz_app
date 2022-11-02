import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  static const name = 'settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text('Settings')),
    );
  }
}