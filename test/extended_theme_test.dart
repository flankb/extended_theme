import 'package:extended_theme/extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_themes.dart';

void main() {
  testWidgets('Skins test', (WidgetTester tester) async {
    // Поискать внутренности ThemeScope
    // final messageFinder = find.text('M');

    // // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // // that the Text widgets appear exactly once in the widget tree.
    // expect(titleFinder, findsOneWidget);
    // expect(messageFinder, findsOneWidget);

    await tester.pumpWidget(TestApp(initialTheme: MagentaLight));

    MaterialApp app = find.byType(MaterialApp).evaluate().first.widget;
    expect(app.theme.primaryColor.value, equals(0xffcc0066));

    ThemeScope<TestTheme> themeScope =
        find.byType(typeOf<ThemeScope<TestTheme>>()).evaluate().first.widget;
    expect(themeScope.availableThemes.entries.isNotEmpty, true);
    expect(themeScope.initialThemeId, equals(MagentaLight));

    await tester.pump();

    await tester.tap(find.byType(FlatButton));

    // Rebuild the widget after the state has changed.
    await tester.pump();

    Container container = find.byType(Container).evaluate().first.widget;
    expect(container.color, equals(appThemes[GreenDark].material.primaryColor));
  });
}

Type typeOf<T>() => T;

class TestApp extends StatelessWidget {
  //final ThemeController<AppTheme> themeController;
  final String initialTheme;

  const TestApp({Key key, this.initialTheme}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeScope<TestTheme>(
      initialThemeId: initialTheme,
      availableThemes: appThemes,
      themeBuilder: (context, appTheme) {
        debugPrint('Builder build');

        return MaterialApp(
          title: 'Flutter Extended Theme Test',
          theme: appTheme.material,
          home: Container(
            color:
                ThemeHolder.themeOf<TestTheme>(context).material.primaryColor,
            //ThemeHolder.of<TestTheme>(context).theme.material.primaryColor,
            child: Center(
                child: FlatButton(
              onPressed: () {
                ThemeHolder.of<TestTheme>(context).updateThemeById(GreenDark);
              },
              child: Text('Change theme'),
            )),
          ),
        );
      },
    );
  }
}
