import 'package:flutter/material.dart';

class UiConfig {
  UiConfig._();
  static String get title => 'No seu bolso';
  static ThemeData get theme => ThemeData(
        primaryColor: const Color(0xFF182b4f),
        primaryColorDark: const Color(0xFF031333),
        primaryColorLight: const Color(0xFF435373),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF182b4f),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF435373),
        ),
        fontFamily: 'Luxurios',
      );
}
