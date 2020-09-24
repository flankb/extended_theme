import 'package:extended_theme/extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme extends ExtendedTheme {
  final Color shadowColor;
  final buttonPauseColor;
  final subtitleColor;

  AppTheme(ThemeData materialTheme,
      {this.shadowColor, this.buttonPauseColor, this.subtitleColor})
      : super(materialTheme: materialTheme);
}

extension InheritedThemeExtensions on BuildContext {
  ThemeController<AppTheme> t2() {
    return this.t<AppTheme>();
  }
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

final appThemeData = {
  MagentaLight: AppTheme(
      baseTheme.copyWith(
        primaryColor: const Color(0xffcc0066),
        toggleableActiveColor: const Color(0xffcc0066),
        focusColor: const Color(0xffcc0066),
        accentColor: const Color(0xffcc0066),
      ),
      subtitleColor: const Color(0xff8e8e8e)),

  MagentaDark: AppTheme(
      baseThemeDark.copyWith(
        primaryColor: const Color(0xffcc0066),
        toggleableActiveColor: const Color(0xffcc0066),
        focusColor: const Color(0xffcc0066),
        accentColor: const Color(0xffcc0066),
      ),
      subtitleColor: const Color(0xffA5A5A5)),

  GreenLight: AppTheme(
      baseTheme.copyWith(
        primaryColor: Colors.green,
        toggleableActiveColor: Colors.green,
        focusColor: Colors.green,
        accentColor: Colors.green,
      ),
      subtitleColor: const Color(0xff8e8e8e)),

  GreenDark: AppTheme(
      baseThemeDark.copyWith(
        primaryColor: Colors.green[700],
        accentColor: Colors.green[700],
        toggleableActiveColor: Colors.green[700],
        focusColor: Colors.green[700],
      ),
      subtitleColor: const Color(0xffA5A5A5)),

  BlueLight: AppTheme(
    baseTheme.copyWith(
      primaryColor: Colors.blue,
      toggleableActiveColor: Colors.blue,
      accentColor: Colors.blue,
    ),
    subtitleColor: const Color(0xff8e8e8e),
  ),

  BlueDark: AppTheme(
      baseThemeDark.copyWith(
        primaryColor: Colors.blue[700],
        toggleableActiveColor: Colors.blue[700],
        accentColor: Colors.blue[700],
      ),
      subtitleColor: const Color(0xffA5A5A5)) //
};
