import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(MaterialApp(
    title: 'hello',
    home: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawer'),
      ),
      drawer: Drawer(
        elevation: 20.0,
        child: Container(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              children: [
                Text('Item1'),
                Text('Items2'),
                RaisedButton(
                  child: Text('back'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
        semanticLabel: '设置',
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[Text('home')],
          ),
        ),
      ),
    );
  }
}
