import 'package:basic_app/screens/home.dart';
import 'package:flutter/material.dart';

const _titleApp = 'Murillo First App';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _titleApp,
      theme: ThemeData(
        colorScheme: const ColorScheme.highContrastDark(
          primary: Colors.white,
          secondary: Colors.red,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}
