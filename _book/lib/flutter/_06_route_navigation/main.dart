import 'package:flutter/material.dart';
import 'first_page.dart';
import 'second_page.dart';
import 'third_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello',
      home: FirstPage(),
      routes: <String, WidgetBuilder>{
        '/FirstPage': (ctx) => FirstPage(),
        '/SecondPage': (ctx) => SecondPage(),
        '/ThirdPage': (ctx) => ThirdPage(),
      },
    );
  }
}
