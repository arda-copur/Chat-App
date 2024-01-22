import 'package:flutter/material.dart';

class IntroPageFirst extends StatelessWidget {
  const IntroPageFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[100],
      child: const Center(child: Text("Page First"),),
    );
  }
}