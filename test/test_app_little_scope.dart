import 'package:extended_theme/extended_theme.dart';
import 'package:flutter/material.dart';

class TestAppLittleScope extends StatelessWidget {
  //final TestTheme initialTheme;

  const TestAppLittleScope({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Extended Theme Test (Little scope)',
        theme: ThemeData.light(),
        home: LittleHomeTestPage());
  }
}

class LittleHomeTestPage extends StatefulWidget {
  LittleHomeTestPage({Key? key}) : super(key: key);

  @override
  _LittleHomeTestPageState createState() => _LittleHomeTestPageState();
}

class _LittleHomeTestPageState extends State<LittleHomeTestPage> {
  ExtendedTheme? _someTheme;
  ExtendedTheme? _someTheme2;

  @override
  void initState() {
    super.initState();

    _someTheme = ExtendedTheme(
        material: ThemeData.dark().copyWith(primaryColor: Colors.red));

    _someTheme2 = ExtendedTheme(
        material: ThemeData.dark().copyWith(primaryColor: Colors.pink));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Some text'),
        ThemeScope(
            theme: _someTheme,
            themeBuilder: (context, dynamic theme) {
              return Theme(
                data: _someTheme!.material!,
                child: Container(
                  key: ValueKey('cnt_1'),
                  color: ThemeHolder.themeOf<ExtendedTheme>(context)!
                      .material!
                      .primaryColor,
                  height: 50,
                  width: 50,
                ),
              );
            }),
        ThemeScope(
            theme: _someTheme2,
            themeBuilder: (context, dynamic theme) {
              return Container(
                key: ValueKey('cnt_2'),
                color: ThemeHolder.themeOf<ExtendedTheme>(context)!
                    .material!
                    .primaryColor,
                height: 20,
                width: 150,
              );
            }),
        FlatButton(
            onPressed: () {
              setState(() {
                _someTheme = ExtendedTheme(
                    material:
                        ThemeData.dark().copyWith(primaryColor: Colors.green));

                _someTheme2 = ExtendedTheme(
                    material:
                        ThemeData.dark().copyWith(primaryColor: Colors.brown));
              });
            },
            child: Text('Update theme'))
      ],
    );
  }
}
