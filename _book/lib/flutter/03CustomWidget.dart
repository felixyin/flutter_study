import 'package:flutter/material.dart';
import '03HelloWorldWidget.dart';

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
  Widget _test() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: HelloWorldWidget(),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: HelloWorldWidget(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            HelloWorldWidget(),
            HelloWorldWidget(),
            HelloWorldWidget(),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello world'),
      ),
      body: Center(
        child: _test(),
      ),
    );
  }
}
