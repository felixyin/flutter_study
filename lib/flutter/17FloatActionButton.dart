import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MainApp(),
    ));

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  DateTime _nowTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FloatingActionButton'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[500],
        child: Icon(Icons.timer),
        onPressed: _onPressed,
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('now: ${this._nowTime}'),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressed() => setState(() {
        DateTime time = DateTime.now();
        this._nowTime = time;
      });
}
