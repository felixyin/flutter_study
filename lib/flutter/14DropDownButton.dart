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
  List<String> _menus = List<String>();
  String _value;

  _MyAppState() {
    for (int i = 1; i < 8; i++) {
      String text = 'menu - $i';
      _menus.add(text);
    }
    _value = _menus.elementAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DropDownButton')),
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
        Text('dropdown'),
        DropdownButton(
          value: this._value,
          items: buildDropdownMenuItems(),
          onChanged: (value) {
            setState(() {
              this._value = value;
            });
          },
        ),
      ];

  List<DropdownMenuItem> buildDropdownMenuItems() {
    return this._menus.map((String value) {
      return DropdownMenuItem(
        value: value,
        child: Row(
          children: <Widget>[
            Icon(Icons.arrow_forward),
            Text('item: $value'),
          ],
        ),
      );
    }).toList();
  }
}
