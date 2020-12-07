library extended_theme;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Generic typedef:
// https://stackoverflow.com/questions/51092028/how-to-typedef-a-generic-function
typedef ThemedWidgetBuilder<TTheme extends ExtendedTheme> = Widget Function(
    BuildContext context, TTheme theme);

class ExtendedTheme {
  final ThemeData materialThemeData;
  final CupertinoThemeData cupertinoThemeData;

  @mustCallSuper
  ExtendedTheme({this.materialThemeData, this.cupertinoThemeData})
      : assert(materialThemeData != null || cupertinoThemeData != null);
}

/// Widget for managing the application themes
/// Wrap in it your root widget to manage the application theme
class StatefulThemeProvider<TTheme extends ExtendedTheme>
    extends StatefulWidget {
  /// Defines the original theme from which your application will be started.
  /// If you use this field, you should also define the theme map - [availableThemes]
  final String initialThemeId;

  /// Predefined themes (skins) for you app
  final Map<String, TTheme> availableThemes;

  /// Initial theme if you do not want to use predefined themes
  final TTheme initialTheme;

  /// Root widget builder
  final ThemedWidgetBuilder<TTheme> themeBuilder;

  const StatefulThemeProvider(
      {Key key,
      this.initialThemeId,
      this.availableThemes,
      this.initialTheme,
      this.themeBuilder})
      : super(key: key);

  @override
  _StatefulThemeProviderState<TTheme> createState() =>
      _StatefulThemeProviderState<TTheme>();

  /// Link to theme controller
  static ThemeHolder<TTheme> of<TTheme extends ExtendedTheme>(
      BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedTheme<TTheme>>()
        .stateTheme
        .themeFacade;
  }
}

/// A controller that stores a link to theme and allows you to update it
class ThemeHolder<TTheme extends ExtendedTheme> {
  final _StatefulThemeProviderState<TTheme> _facilityState;

  ThemeHolder(this._facilityState);

  /// Current theme identifier if you use predefined map of themes
  /// Equals null if you update theme in runtime by method [updateTheme]
  String get currentThemeId => _facilityState.themeId;

  /// Current theme. Use this in the Widget tree for getting of theme properties
  TTheme get currentTheme => _facilityState.theme;

  /// Update the theme by the identifier that is
  /// contained in the map of themes you have defined
  updateThemeById(String themeId) {
    _facilityState.updateThemeById(themeId);
  }

  /// Update the theme by theme object
  updateTheme(TTheme theme) {
    _facilityState.updateTheme(theme);
  }
}

class _StatefulThemeProviderState<TTheme extends ExtendedTheme>
    extends State<StatefulThemeProvider<TTheme>> {
  String _themeId;
  TTheme _theme;

  ThemeHolder<TTheme> _facade;

  String get themeId => _themeId;
  TTheme get theme =>
      _themeId != null ? widget.availableThemes[_themeId] : _theme;

  ThemeHolder<TTheme> get themeFacade => _facade;

  void _checkThemeId(String newThemeId) {
    if (!widget.availableThemes.containsKey(newThemeId)) {
      throw Exception("Themes does not contains this key!");
    }
  }

  updateThemeById(String newThemeId) {
    if (_themeId != newThemeId) {
      _checkThemeId(newThemeId);

      setState(() {
        _themeId = newThemeId;
        debugPrint("Updated theme: " + newThemeId.toString());
      });
    }
  }

  updateTheme(TTheme theme) {
    setState(() {
      _themeId = null;
      _theme = theme;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialThemeId != null && widget.initialTheme != null) {
      throw Exception(
          "It is not allowed to specify both the identifier and an instance of the theme!");
    }

    if (widget.initialThemeId != null) {
      if (widget.availableThemes == null) {
        throw Exception(
            "When passing an identifier, you need to specify the map of themes!");
      } else {
        _checkThemeId(widget.initialThemeId);
      }
    }

    _facade = ThemeHolder(this);

    _themeId = widget.initialThemeId;
    _theme = widget.initialTheme;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('_StatefulThemeProviderState build');

    return InheritedTheme<TTheme>(
      stateTheme: this,
      child: Builder(builder: (contextCool) {
        return widget.themeBuilder(context, theme);
      }),
    );
  }
}

class InheritedTheme<TTheme extends ExtendedTheme> extends InheritedWidget {
  final _StatefulThemeProviderState<TTheme> stateTheme;

  InheritedTheme({Key key, this.stateTheme, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
