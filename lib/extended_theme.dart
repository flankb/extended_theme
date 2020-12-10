library extended_theme;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef ThemedWidgetBuilder<TTheme extends ExtendedTheme> = Widget Function(
    BuildContext context, TTheme theme);

/// Base class for themes.
/// You can use this class directly without creating any descendants
class ExtendedTheme {
  final ThemeData material;
  final CupertinoThemeData cupertino;

  @mustCallSuper
  ExtendedTheme({this.material, this.cupertino})
      : assert(material != null || cupertino != null);

  ExtendedTheme copyWith({
    ThemeData material,
    CupertinoThemeData cupertino,
  }) {
    return ExtendedTheme(
      material: material ?? this.material,
      cupertino: cupertino ?? this.cupertino,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ExtendedTheme &&
        o.material == material &&
        o.cupertino == cupertino;
  }

  @override
  int get hashCode => material.hashCode ^ cupertino.hashCode;
}

/// Widget for managing the application themes
/// Wrap in it your root widget to manage the application theme
class ThemeScope<TTheme extends ExtendedTheme> extends StatefulWidget {
  /// Defines the original theme from which your application will be started.
  /// If you use this field, you should also define the theme map - [availableThemes]
  final String initialThemeId;

  /// Predefined themes (skins) for you app
  final Map<String, TTheme> availableThemes;

  /// Initial theme if you do not want to use predefined themes
  final TTheme initialTheme;

  /// Root widget builder
  final ThemedWidgetBuilder<TTheme> themeBuilder;

  const ThemeScope(
      {Key key,
      this.initialThemeId,
      this.availableThemes,
      this.initialTheme,
      this.themeBuilder})
      : super(key: key);

  @override
  _ThemeScopeState<TTheme> createState() => _ThemeScopeState<TTheme>();
}

/// A controller that stores a link to theme and allows you to update it
class ThemeHolder<TTheme extends ExtendedTheme> {
  final _ThemeScopeState<TTheme> _facilityState;

  ThemeHolder(this._facilityState);

  /// Current theme identifier if you use predefined map of themes
  /// Equals null if you update theme in runtime by method [updateTheme]
  String get themeId => _facilityState.themeId;

  /// Current theme. Use this in the Widget tree for getting of theme properties
  TTheme get theme => _facilityState.theme;

  /// Update the theme by the identifier that is
  /// contained in the map of themes you have defined
  updateThemeById(String themeId) {
    _facilityState.updateThemeById(themeId);
  }

  /// Update the theme by theme object
  updateTheme(TTheme theme) {
    _facilityState.updateTheme(theme);
  }

  /// Link to theme controller object, use this for managing themes
  static ThemeHolder<TTheme> of<TTheme extends ExtendedTheme>(
      BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedTheme<TTheme>>()
        .stateTheme
        .themeFacade;
  }

  /// Current theme, use this in the Widget tree for getting theme properties
  static TTheme themeOf<TTheme extends ExtendedTheme>(BuildContext context) {
    return ThemeHolder.of<TTheme>(context).theme;
  }
}

class _ThemeScopeState<TTheme extends ExtendedTheme>
    extends State<ThemeScope<TTheme>> {
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

    return _InheritedTheme<TTheme>(
      stateTheme: this,
      child: Builder(builder: (themeContext) {
        return widget.themeBuilder(themeContext, theme);
      }),
    );
  }
}

class _InheritedTheme<TTheme extends ExtendedTheme> extends InheritedWidget {
  final _ThemeScopeState<TTheme> stateTheme;

  _InheritedTheme({Key key, this.stateTheme, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant _InheritedTheme<TTheme> oldWidget) {
    return oldWidget.stateTheme.themeId != stateTheme.themeId ||
        oldWidget.stateTheme.theme != stateTheme.theme; //true;
  }
}
