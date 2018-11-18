import 'package:flutter/material.dart';

class HelloWorldWidget extends StatelessWidget {
  const HelloWorldWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: Text('hello'),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Text('hello'),
        ),
      ],
    );
  }
}
