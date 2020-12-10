import 'package:extended_theme/extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app_predefined.dart';
import 'test_app_runtime.dart';
import 'test_themes.dart';

Type typeOf<T>() => T;

void main() {
  testWidgets('Skins test', (WidgetTester tester) async {
    await tester.pumpWidget(TestAppPredefined(initialThemeId: MagentaLight));

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

    final textWithThemeId =
        find.byKey(ValueKey('themeIdText')).evaluate().first.widget as Text;
    expect(textWithThemeId.data, equals(GreenDark));
  });

  testWidgets('Runtime themes test', (WidgetTester tester) async {
    final theme = TestTheme(ThemeData(accentColor: Colors.blueGrey),
        subtitleColor: Colors.grey);

    await tester.pumpWidget(TestAppRuntime(initialTheme: theme));

    MaterialApp app = find.byType(MaterialApp).evaluate().first.widget;
    expect(app.theme.accentColor, equals(Colors.blueGrey));

    ThemeScope<TestTheme> themeScope =
        find.byType(typeOf<ThemeScope<TestTheme>>()).evaluate().first.widget;
    expect(themeScope.availableThemes == null, true);
    expect(themeScope.initialThemeId == null, true);

    await tester.pump();
    await tester.tap(find.byType(FlatButton));
    await tester.pump();

    Container container = find.byType(Container).evaluate().first.widget;
    expect(container.color, equals(Colors.red));

    final textWithThemeInfo =
        find.byKey(ValueKey('themeIdText')).evaluate().first.widget as Text;

    expect(textWithThemeInfo.data, equals(Colors.yellow.value.toString()));
  });
}
