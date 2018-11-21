import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'hello',
    home: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AlertDialog'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: '请输入一些内容'),
                onChanged: (value) {
                  this._text = value;
                },
              ),
              FlatButton(
                onPressed: () => _onShowDialog(context),
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 5.0,
                      style: BorderStyle.solid,
                      color: Colors.red,
                    ),
                  ),
                  child: Text('click'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onShowDialog(context) {
    if (this._text.isEmpty) return;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('hello dialog'),
          content: Center(
            child: Text(this._text),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('ok'),
            ),
          ],
        );
      },
    );
  }
}
