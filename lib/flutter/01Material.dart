import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '例子',
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  Widget _button() {
    return RaisedButton(
      onPressed: null,
      child: Text('click'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello world'),
      ),
      body: Center(
        child: _button(),
      ),
    );
  }
}
