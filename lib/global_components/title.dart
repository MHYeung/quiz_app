import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w600, color: Colors.amber),
        ),
      ),
    );
  }
}
