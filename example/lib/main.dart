import 'package:extended_theme/extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Read last theme from [SharedPreferences] for simple example
  /// Avoid [async] in main method for production. Try to use FutureBuilder or other async widgets
  final initialTheme = await _readLastTheme();

  runApp(MyApp(
    initialTheme: initialTheme,
  ));
}

Future<String> _readLastTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final themeStr = prefs.getString('PREF_THEME') ?? GreenLight;
  return themeStr;
}

class MyApp extends StatelessWidget {
  final String initialTheme;

  const MyApp({Key key, this.initialTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeScope<AppTheme>(
      initialThemeId: initialTheme,
      availableThemes: appThemes,
      themeBuilder: (context, appTheme) {
        debugPrint('Builder build');

        return MaterialApp(
          title: 'Flutter Demo',
          theme: appTheme.material,
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            ThemeHolder.themeOf<AppTheme>(context).buttonPauseColor,
        onPressed: () {
          final themeKeys = appThemes.keys.toList();
          ThemeHolder.of<AppTheme>(context)
              .updateThemeById(themeKeys[_counter % themeKeys.length]);

          _incrementCounter();
        },
        tooltip: 'Next theme',
        child: Icon(Icons.colorize),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
