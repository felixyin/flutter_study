import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello',
      home: Scaffold(
        appBar: AppBar(
          title: Text('CheckBox'),
        ),
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    '复选框：',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Checkbox(
                    onChanged: (bool value) {
                      setState(() {
                        this._checked = !this._checked;
                      });
                    },
                    value: this._checked,
                  ),
                ],
              ),
              CheckboxListTile(
                title: Text('测试复选框绑定'),
                subtitle: Text('双向绑定'),
                activeColor: Colors.pinkAccent,
                secondary: Icon(Icons.alarm_on),
                onChanged: (bool value) {
                  setState(() {
                    this._checked = !this._checked;
                  });
                },
                value: this._checked,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
