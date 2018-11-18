import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('Radio')),
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

  List<Widget> _buildRows() {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < 3; i++) {
      Row row = Row(
        children: <Widget>[
          Expanded(
            child: Text('data' + this._selectedValue.toString()),
          ),
          Radio(
            groupValue: this._selectedValue,
            onChanged: _onRadioClick,
            value: i,
          )
        ],
      );
      list.add(row);
    }

    list.add(Divider());
    for (int i = 0; i < 3; i++) {
      list.add(RadioListTile(
        groupValue: this._selectedValue,
        onChanged: _onRadioClick,
        value: i,
        activeColor: Colors.red[200],
        title: Text('data$i'),
        subtitle: Text('sub data$i'),
        secondary: Icon(Icons.power),
        isThreeLine: false,
        dense: false,
      ));
      list.add(Divider());
    }

    return list;
  }

  _onRadioClick(int value) {
    setState(() {
      this._selectedValue = value;
    });
  }
}
