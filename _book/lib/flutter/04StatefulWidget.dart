import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  String _state = 'no state';
  String _title = 'hello';
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this._title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(this._title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_alert),
              onPressed: () => _onPressed('add_alert'),
            ),
          ],
        ),
        body: Center(
          child: Text(
            this._state,
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
    );
  }

  _onPressed(String s) {
    print(s);
    this._count++;
    this._state = 'change state$_count';
    setState(() {}); // change state
  }
}
