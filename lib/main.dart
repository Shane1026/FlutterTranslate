import 'package:flutter/material.dart';
import 'package:translate/open_screen.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData(
        cupertinoOverrideTheme: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
      dateTimePickerTextStyle: TextStyle(color: Colors.blue, fontSize: 16),
      pickerTextStyle: TextStyle(color: Colors.blue, fontSize: 12),
    )));
    return MaterialApp(
      home: OpenScreen(),
    );
  }
}
