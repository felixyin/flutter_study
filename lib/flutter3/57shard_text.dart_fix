import 'package:flutter/material.dart';
import 'package:shaded_text/shaded_text.dart';

void main() => runApp(MaterialApp(
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
        title: Text('Custom Flutter Package'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: ShadedText(
            shadeBuilder: (BuildContext context, String text, Color color) {
              return Container(
                child: Text(
                  text,
                  style: TextStyle(color: color),
                ),
              );
            },
            shadeColor: Colors.blueAccent.withOpacity(0.4),
            text: '你好，这个组件是自己编写的',
            textColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
