import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final title = "滑动列表";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Page1(),
    );
  }
}

class Page1 extends StatelessWidget {
  static String title = "Page1";

  @override
  Widget build(BuildContext context) {
    final items = List<int>.generate(50, (i) => i);
    return Scaffold(
      appBar: AppBar(
        title: Text(Page1.title),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("goto page2"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (bc) {
              return Page2();
            }));
          },
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  static String title = "Page2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Page2.title),
        backgroundColor: Colors.green[900],
      ),
      body: Center(
        child: RaisedButton(
          child: Text("back page1"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
