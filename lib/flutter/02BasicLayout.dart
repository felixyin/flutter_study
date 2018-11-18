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
  Widget _test() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text('hello'),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text('world'),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text('hello'),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text('hello'),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text('hello'),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text('hello'),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text('world'),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text('world'),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text('!!!'),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text('!!!'),
                ),
              ],
            ),
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
