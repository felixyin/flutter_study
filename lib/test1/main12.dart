import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final title = "用户交互";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: MyHome(title: title),
    );
  }
}

class MyHome extends StatelessWidget {
  final String title;

  const MyHome({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(child: MyButton()),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final s = Scaffold.of(context);
        s.hideCurrentSnackBar();
        final sb = SnackBar(
          content: Text("提示语句!!"),
        );
        s.showSnackBar(sb);
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(color: Colors.pink, width: 1.0),
        ),
        child: Text(
          "click me!",
          style: TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
