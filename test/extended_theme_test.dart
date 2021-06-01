import 'package:extended_theme/extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app_little_scope.dart';
import 'test_app_predefined.dart';
import 'test_app_runtime.dart';
import 'test_themes.dart';

Type typeOf<T>() => T;

void main() {
  testWidgets('Skins test', (WidgetTester tester) async {
    await tester.pumpWidget(TestAppPredefined(initialThemeId: MagentaLight));

    var app = find.byType(MaterialApp).evaluate().first.widget as MaterialApp;
    expect(app.theme!.primaryColor.value, equals(0xffcc0066));

    var themeScope = find
        .byType(typeOf<ThemeScope<TestTheme>>())
        .evaluate()
        .first
        .widget as ThemeScope<TestTheme>;
    expect(themeScope.availableThemes!.entries.isNotEmpty, true);
    expect(themeScope.themeId, equals(MagentaLight));

    await tester.pump();

    await tester.tap(find.byType(TextButton));

    // Rebuild the widget after the state has changed.
    await tester.pump();

    var container = find.byType(Container).evaluate().first.widget as Container;
    expect(
        container.color, equals(appThemes[GreenDark]!.material!.primaryColor));

    final textWithThemeId =
        find.byKey(ValueKey('themeIdText')).evaluate().first.widget as Text;
    expect(textWithThemeId.data, equals(GreenDark));
  });

  testWidgets('Runtime themes test', (WidgetTester tester) async {
    final theme = TestTheme(ThemeData(accentColor: Colors.blueGrey),
        subtitleColor: Colors.grey);

    await tester.pumpWidget(TestAppRuntime(initialTheme: theme));

    var app = find.byType(MaterialApp).evaluate().first.widget as MaterialApp;
    expect(app.theme!.accentColor, equals(Colors.blueGrey));

    var themeScope = find
        .byType(typeOf<ThemeScope<TestTheme>>())
        .evaluate()
        .first
        .widget as ThemeScope<TestTheme>;
    expect(themeScope.availableThemes == null, true);
    expect(themeScope.themeId == null, true);

    await tester.pump();
    await tester.tap(find.byType(TextButton));
    await tester.pump();

    var container = find.byType(Container).evaluate().first.widget as Container;
    expect(container.color, equals(Colors.red));

    final textWithThemeInfo =
        find.byKey(ValueKey('themeIdText')).evaluate().first.widget as Text;

    expect(textWithThemeInfo.data, equals(Colors.yellow.value.toString()));
  });

  testWidgets('Little themes scope test', (WidgetTester tester) async {
    Container _findContainer(String key) {
      return find.byKey(ValueKey(key)).evaluate().first.widget as Container;
    }

    await tester.pumpWidget(TestAppLittleScope());

    var container1 = _findContainer('cnt_1');
    expect(container1.color, Colors.red);

    var container2 = _findContainer('cnt_2');
    expect(container2.color, Colors.pink);

    await tester.tap(find.text('Update theme'));
    await tester.pump();

    expect(_findContainer('cnt_1').color, Colors.green);
    expect(_findContainer('cnt_2').color, Colors.brown);
  });
}
