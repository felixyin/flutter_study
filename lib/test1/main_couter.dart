import 'package:flutter/material.dart';
import 'CouterDisplay.dart';
import 'CouterButton.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Flutter Tutorial',
    home: Scaffold(
      appBar: AppBar(
        title: Text("例子"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[new Counter()],
        ),
      ),
    ),
  ));
}

class Counter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CounterState();
  }
}

class CounterState extends State<Counter> {
  int count = 0;

  void increment() {
    setState(() {
      ++count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CounterButton(this.increment),
        CouterDisplay(this.count)
      ],
    );
  }
}
