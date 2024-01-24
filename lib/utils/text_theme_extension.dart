import 'package:flutter/material.dart';

extension TextThemeExtension on BuildContext {
  TextTheme projectTheme() {
    return Theme.of(this).textTheme;
  }
}