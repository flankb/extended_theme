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

class ThemeController<TTheme extends ExtendedTheme> extends ChangeNotifier {
  String _appTheme;
  Map<String, TTheme> _availableThemes;

  ThemeController(String initialTheme, Map<String, TTheme> availableThemes) {
    _appTheme = initialTheme;
    _availableThemes = availableThemes;
  }

  String get theme => _appTheme;
  TTheme get themeData => _availableThemes[_appTheme];

  updateTheme(String newTheme) {
    if (_appTheme != newTheme) {
      _appTheme = newTheme;

      debugPrint("Updated theme: " + newTheme.toString());

      notifyListeners();
    }
  }
}

class InheritedThemeNotifier<TTheme extends ExtendedTheme>
    extends InheritedNotifier<ThemeController<TTheme>> {
  final ThemeController<TTheme> controller;

  const InheritedThemeNotifier(
      {Key key, @required Widget child, @required this.controller})
      : super(key: key, child: child, notifier: controller);

  static ThemeController<TTheme> of<TTheme extends ExtendedTheme>(
      BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedThemeNotifier<TTheme>>()
        .controller;
  }
}

extension InheritedThemeExtensions on BuildContext {
  ThemeController<T> extTheme<T extends ExtendedTheme>() {
    return this
        .dependOnInheritedWidgetOfExactType<InheritedThemeNotifier<T>>()
        .controller;
  }
}
