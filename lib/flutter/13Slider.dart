import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _value = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Slider')),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildRows(),
        ),
      ),
    );
  }

  List<Widget> _buildRows() => <Widget>[
        Text('slider: ${this._value}'),
        Slider(
          onChanged: (double value) {
            setState(() {
              this._value = value;
            });
          },
          value: this._value,
          min: 0,
          max: 100,
        ),
        Divider(),
        Text('LinearProgressIndicator, 只能显示不能修改'),
        LinearProgressIndicator(
          value: this._value * 0.01,
        ),
        Divider(),
        Text('LinearProgressIndicator'),
        CircularProgressIndicator(),
        Divider(),
        Text('RefreshProgressIndicator'),
        RefreshProgressIndicator()
      ];
}
