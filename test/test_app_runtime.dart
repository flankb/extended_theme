import 'package:extended_theme/extended_theme.dart';
import 'package:flutter/material.dart';

import 'test_themes.dart';

class TestAppRuntime extends StatelessWidget {
  final TestTheme? initialTheme;

  const TestAppRuntime({Key? key, this.initialTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeScope<TestTheme>(
      theme: initialTheme,
      themeBuilder: (context, appTheme) {
        return MaterialApp(
          title: 'Flutter Extended Theme Test (Runtime)',
          theme: appTheme.material,
          home: Container(
            color:
                ThemeHolder.themeOf<TestTheme>(context)!.material!.accentColor,
            child: Column(
              children: [
                Center(
                    child: TextButton(
                  onPressed: () {
                    final newTheme = TestTheme(
                        ThemeData(accentColor: Colors.red),
                        subtitleColor: Colors.yellow);

                    ThemeHolder.of<TestTheme>(context)!.updateTheme(newTheme);
                  },
                  child: Text('Change theme'),
                )),
                Text(
                  ThemeHolder.of<TestTheme>(context)!
                      .theme!
                      .subtitleColor!
                      .value
                      .toString(),
                  key: ValueKey('themeIdText'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
