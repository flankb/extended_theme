import 'package:extended_theme/extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:google_fonts/google_fonts.dart';

class AppTheme extends ExtendedTheme {
  final Color? shadowColor;
  final Color? buttonPauseColor;
  final Color? subtitleColor;
  final double? centerFontSize;

  AppTheme(ThemeData material,
      {this.shadowColor,
      this.buttonPauseColor,
      this.subtitleColor,
      this.centerFontSize})
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
      baseTheme.copyWith(primaryColor: const Color(0xffcc0066)),
      subtitleColor: const Color(0xff8e8e8e),
      centerFontSize: 28),

  MagentaDark: AppTheme(
      baseThemeDark.copyWith(primaryColor: const Color(0xffcc0066)),
      subtitleColor: const Color(0xffA5A5A5),
      centerFontSize: 14),

  GreenLight: AppTheme(baseTheme.copyWith(primaryColor: Colors.green),
      subtitleColor: const Color(0xff8e8e8e), centerFontSize: 22),

  GreenDark: AppTheme(baseThemeDark.copyWith(primaryColor: Colors.green[700]),
      subtitleColor: const Color(0xffA5A5A5), centerFontSize: 12),

  BlueLight: AppTheme(baseTheme.copyWith(primaryColor: Colors.blue),
      subtitleColor: const Color(0xff8e8e8e), centerFontSize: 14),

  BlueDark: AppTheme(baseThemeDark.copyWith(primaryColor: Colors.blue[700]),
      subtitleColor: const Color(0xffA5A5A5), centerFontSize: 10) //
};

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
  var prefs = await SharedPreferences.getInstance();

  final themeStr = prefs.getString('PREF_THEME') ?? GreenLight;
  return themeStr;
}

class MyApp extends StatelessWidget {
  final String initialTheme;

  const MyApp({Key? key, required this.initialTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeScope<AppTheme>(
      themeId: initialTheme,
      availableThemes: appThemes,
      themeBuilder: (context, appTheme) {
        debugPrint('Builder build');

        return MaterialApp(
          title: 'Flutter Demo',
          theme: appTheme.material,
          home: MyHomePage(title: 'Flutter Extended Theme'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

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
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have changed the theme many times:',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize:
                      ThemeHolder.themeOf<AppTheme>(context).centerFontSize),
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
