import 'package:extended_theme/extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme extends ExtendedTheme {
  final Color shadowColor;
  final Color buttonPauseColor;
  final Color subtitleColor;

  AppTheme(ThemeData material,
      {this.shadowColor, this.buttonPauseColor, this.subtitleColor})
      : super(material: material);
}

// static S of(BuildContext context) {
//     return Localizations.of<S>(context, S);
//   }

// extension InheritedThemeExtensions on BuildContext {
//   ThemeController<AppTheme> t2() {
//     return this.t<AppTheme>();
//   }
// }

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
      baseTheme.copyWith(primaryColor: const Color(0xffcc0066)),
      subtitleColor: const Color(0xff8e8e8e)),

  MagentaDark: AppTheme(
      baseThemeDark.copyWith(primaryColor: const Color(0xffcc0066)),
      subtitleColor: const Color(0xffA5A5A5)),

  GreenLight: AppTheme(baseTheme.copyWith(primaryColor: Colors.green),
      subtitleColor: const Color(0xff8e8e8e)),

  GreenDark: AppTheme(baseThemeDark.copyWith(primaryColor: Colors.green[700]),
      subtitleColor: const Color(0xffA5A5A5)),

  BlueLight: AppTheme(
    baseTheme.copyWith(primaryColor: Colors.blue),
    subtitleColor: const Color(0xff8e8e8e),
  ),

  BlueDark: AppTheme(baseThemeDark.copyWith(primaryColor: Colors.blue[700]),
      subtitleColor: const Color(0xffA5A5A5)) //
};
