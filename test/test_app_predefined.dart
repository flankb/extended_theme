import 'package:extended_theme/extended_theme.dart';
import 'package:flutter/material.dart';

import 'test_themes.dart';

class TestAppPredefined extends StatelessWidget {
  final String initialThemeId;

  const TestAppPredefined({Key key, this.initialThemeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeScope<TestTheme>(
      themeId: initialThemeId,
      availableThemes: appThemes,
      themeBuilder: (context, appTheme) {
        return MaterialApp(
          title: 'Flutter Extended Theme Test (Skins)',
          theme: appTheme.material,
          home: Container(
            color:
                ThemeHolder.themeOf<TestTheme>(context).material.primaryColor,
            child: Column(
              children: [
                Center(
                    child: FlatButton(
                  onPressed: () {
                    ThemeHolder.of<TestTheme>(context)
                        .updateThemeById(GreenDark);
                  },
                  child: Text('Change theme'),
                )),
                Text(
                  ThemeHolder.of<TestTheme>(context).themeId.toString(),
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
