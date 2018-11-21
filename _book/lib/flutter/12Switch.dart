import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('Switch')),
          body: Container(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: _buildRows(),
              ),
            ),
          )),
    );
  }

  List<Widget> _buildRows() => <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text('data: ' + this._switchValue.toString()),
            ),
            Switch(
              onChanged: this._onSwitchClick,
              value: this._switchValue,
            ),
          ],
        ),
        SwitchListTile(
          onChanged: this._onSwitchClick,
          value: this._switchValue,
          title: Text('data: ' + this._switchValue.toString()),
          subtitle: Text('sub title'),
          activeColor: Colors.red[300],
          secondary: Icon(Icons.accessible),
        ),
      ];

  _onSwitchClick(bool value) {
    setState(() {
      this._switchValue = value;
    });
  }
}
