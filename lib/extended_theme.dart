library extended_theme;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExtendedTheme {
  final ThemeData materialTheme;
  final CupertinoThemeData cupertinoThemeData;

  @mustCallSuper
  ExtendedTheme({this.materialTheme, this.cupertinoThemeData})
      : assert(materialTheme != null || cupertinoThemeData != null);
}

class MyCustomThemeHolder extends ExtendedTheme {
  final Color shadowColor;
  final buttonPauseColor;
  final subtitleColor;

  MyCustomThemeHolder(ThemeData materialTheme,
      {this.shadowColor, this.buttonPauseColor, this.subtitleColor})
      : super(materialTheme: materialTheme);
}
