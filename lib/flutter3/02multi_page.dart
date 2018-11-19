import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  accentColor: Colors.red,
  primaryColor: Colors.blue,
);

void main() => runApp(MaterialApp(
      theme: themeData,
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MultiPage'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.of(context).push(TwoPage());
            },
            child: Text('Go Two Page'),
          ),
        ),
      ),
    );
  }
}

class TwoPage extends MaterialPageRoute<Null> {
  TwoPage()
      : super(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('TwoPage'),
              ),
              body: Container(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(ThreePage());
                  },
                  child: Text('Go Three Page'),
                )),
              ),
            );
          },
        );
}

class ThreePage extends MaterialPageRoute<Null> {
  ThreePage()
      : super(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('ThreePage'),
              ),
              body: Container(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil(
                          ModalRoute.withName(Navigator.defaultRouteName));
                    },
                    child: Text('Go Home Page'),
                  ),
                ),
              ),
            );
          },
        );
}
