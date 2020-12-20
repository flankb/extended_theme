import 'package:extended_theme/extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme extends ExtendedTheme {
  final Color shadowColor;
  final Color buttonPauseColor;
  final Color subtitleColor;
  final double centerFontSize;

  AppTheme(ThemeData material, this.centerFontSize,
      {this.shadowColor, this.buttonPauseColor, this.subtitleColor})
      : super(material: material);
}

ThemeData baseTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: GoogleFonts.openSansTextTheme(ThemeData.light().textTheme),
);

ThemeData baseThemeDark = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.openSansTextTheme(ThemeData.dark().textTheme),
);

const MagentaLight = 'MagentaLight';
const MagentaDark = 'MagentaDark';
const GreenLight = 'GreenLight';
const GreenDark = 'GreenDark';
const BlueLight = 'BlueLight';
const BlueDark = 'BlueDark';

final appThemes = {
  MagentaLight: AppTheme(
      baseTheme.copyWith(primaryColor: const Color(0xffcc0066)), 28,
      subtitleColor: const Color(0xff8e8e8e)),

  MagentaDark: AppTheme(
      baseThemeDark.copyWith(primaryColor: const Color(0xffcc0066)), 14,
      subtitleColor: const Color(0xffA5A5A5)),

  GreenLight: AppTheme(baseTheme.copyWith(primaryColor: Colors.green), 22,
      subtitleColor: const Color(0xff8e8e8e)),

  GreenDark: AppTheme(
      baseThemeDark.copyWith(primaryColor: Colors.green[700]), 12,
      subtitleColor: const Color(0xffA5A5A5)),

  BlueLight: AppTheme(
    baseTheme.copyWith(primaryColor: Colors.blue),
    14,
    subtitleColor: const Color(0xff8e8e8e),
  ),

  BlueDark: AppTheme(baseThemeDark.copyWith(primaryColor: Colors.blue[700]), 10,
      subtitleColor: const Color(0xffA5A5A5)) //
};
