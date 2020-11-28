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

// class ThemeController<TTheme extends ExtendedTheme> extends ChangeNotifier {
//   String _themeId;
//   Map<String, TTheme> _availableThemes;

//   ThemeController(String initialTheme, Map<String, TTheme> availableThemes) {
//     _themeId = initialTheme;
//     _availableThemes = availableThemes;
//   }

//   String get themeId => _themeId;
//   TTheme get theme => _availableThemes[_themeId];

//   updateTheme(String newTheme) {
//     if (_themeId != newTheme) {
//       _themeId = newTheme;

//       debugPrint("Updated theme: " + newTheme.toString());

//       notifyListeners();
//     }
//   }
// }

class StatefulThemeProvider<TTheme extends ExtendedTheme>
    extends StatefulWidget {
  final String initialTheme;
  final Map<String, TTheme> availableThemes;
  final ThemedWidgetBuilder<TTheme> themeBuilder;

  const StatefulThemeProvider(
      {Key key, this.initialTheme, this.availableThemes, this.themeBuilder})
      : super(key: key);

  @override
  StatefulThemeProviderState<TTheme> createState() =>
      StatefulThemeProviderState<TTheme>();

  static ThemeFacade<TTheme> of<TTheme extends ExtendedTheme>(
      BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedTheme<TTheme>>()
        .stateTheme
        .themeFacade;
  }
}

class ThemeFacade<TTheme extends ExtendedTheme> {
  final StatefulThemeProviderState<TTheme> _facilityState;

  ThemeFacade(this._facilityState);

  String get currentThemeId => _facilityState.themeId;
  TTheme get currentTheme => _facilityState.theme;

  updateThemeById(String themeId) {
    _facilityState.updateThemeById(themeId);
  }
}

class StatefulThemeProviderState<TTheme extends ExtendedTheme>
    extends State<StatefulThemeProvider<TTheme>> {
  String _themeId;
  ThemeFacade<TTheme> _facade;

  String get themeId => _themeId;
  TTheme get theme => widget.availableThemes[_themeId];

  ThemeFacade<TTheme> get themeFacade => _facade;

  updateThemeById(String newTheme) {
    if (_themeId != newTheme) {
      setState(() {
        _themeId = newTheme;
        debugPrint("Updated theme: " + newTheme.toString());
      });
      //notifyListeners();
    }
  }

  @override
  void initState() {
    super.initState();
    _facade = ThemeFacade(this);
    _themeId = widget.initialTheme;
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
  final StatefulThemeProviderState<TTheme> stateTheme;

  InheritedTheme({Key key, this.stateTheme, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

// class ExtentedThemeNotifier<TTheme extends ExtendedTheme>
//     extends InheritedNotifier<ThemeController<TTheme>> {
//   //final ThemedWidgetBuilder builder;
//   final ThemeController<TTheme> controller;

//   const ExtentedThemeNotifier(
//       {Key key, @required Widget child, @required this.controller})
//       : super(key: key, child: child, notifier: controller);

//   // static ThemeController<TTheme> of<TTheme extends ExtendedTheme>(
//   //     BuildContext context) {
//   //   return context
//   //       .dependOnInheritedWidgetOfExactType<ExtentedThemeNotifier<TTheme>>()
//   //       .controller;
//   // }
// }

// extension ExtendedThemeExtensions on BuildContext {
//   ThemeController<T> t<T extends ExtendedTheme>() {
//     return this
//         .dependOnInheritedWidgetOfExactType<ExtentedThemeNotifier<T>>()
//         .controller;
//   }
// }
