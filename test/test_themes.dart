import 'dart:ui';

import 'package:extended_theme/extended_theme.dart';
import 'package:flutter/material.dart';

class TestTheme extends ExtendedTheme {
  final Color shadowColor;
  final Color buttonPauseColor;
  final Color subtitleColor;

  TestTheme(ThemeData material,
      {this.shadowColor, this.buttonPauseColor, this.subtitleColor})
      : super(material: material);
}

ThemeData baseTheme = ThemeData(
  brightness: Brightness.light,
);

ThemeData baseThemeDark = ThemeData(
  brightness: Brightness.dark,
);

const MagentaLight = 'MagentaLight';
const MagentaDark = 'MagentaDark';
const GreenLight = 'GreenLight';
const GreenDark = 'GreenDark';
const BlueLight = 'BlueLight';
const BlueDark = 'BlueDark';

final appThemes = {
  MagentaLight: TestTheme(
      baseTheme.copyWith(primaryColor: const Color(0xffcc0066)),
      subtitleColor: const Color(0xff8e8e8e)),

  MagentaDark: TestTheme(
      baseThemeDark.copyWith(primaryColor: const Color(0xffcc0066)),
      subtitleColor: const Color(0xffA5A5A5)),

  GreenLight: TestTheme(baseTheme.copyWith(primaryColor: Colors.green),
      subtitleColor: const Color(0xff8e8e8e)),

  GreenDark: TestTheme(baseThemeDark.copyWith(primaryColor: Colors.green[700]),
      subtitleColor: const Color(0xffA5A5A5)),

  BlueLight: TestTheme(
    baseTheme.copyWith(primaryColor: Colors.blue),
    subtitleColor: const Color(0xff8e8e8e),
  ),

  BlueDark: TestTheme(baseThemeDark.copyWith(primaryColor: Colors.blue[700]),
      subtitleColor: const Color(0xffA5A5A5)) //
};
