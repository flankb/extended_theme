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
  String _themeId;
  Map<String, TTheme> _availableThemes;

  ThemeController(String initialTheme, Map<String, TTheme> availableThemes) {
    _themeId = initialTheme;
    _availableThemes = availableThemes;
  }

  String get themeId => _themeId;
  TTheme get theme => _availableThemes[_themeId];

  updateTheme(String newTheme) {
    if (_themeId != newTheme) {
      _themeId = newTheme;

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

/*
extension InheritedThemeExtensions on BuildContext {
  ThemeController<MyCustomTheme> t() {
    return this
        .dependOnInheritedWidgetOfExactType<
            InheritedThemeNotifier<MyCustomTheme>>()
        .controller;
  }
}*/

extension InheritedThemeExtensions on BuildContext {
  ThemeController<T> t<T extends ExtendedTheme>() {
    return this
        .dependOnInheritedWidgetOfExactType<InheritedThemeNotifier<T>>()
        .controller;
  }
}
