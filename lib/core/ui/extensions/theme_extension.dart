import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorDark => Theme.of(this).primaryColorDark;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  Color get accentColor => Theme.of(this).colorScheme.secondary;
  TextTheme get textTheme => Theme.of(this).textTheme;
  Color get darkBlue => const Color(0xFF00384C);
  Color get darkGrey => const Color(0xFF343A40);
  Color get grey => const Color(0xFF5E6770);
  Color get lightGrey => const Color(0xFF868E96);
  Color get white => const Color(0xFFF1F3F5);
  Color get greyBlue => const Color(0xFF6D7070);
  Color get red => const Color(0xFFc41818);
  Color get green => const Color(0xFF4CAF50);
}
