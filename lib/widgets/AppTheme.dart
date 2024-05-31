import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData Light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    );
  }

  static ThemeData Dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
    );
  }
}
