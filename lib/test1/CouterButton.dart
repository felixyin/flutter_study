import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  CounterButton(this.onPress);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("click"),
      onPressed: onPress,
    );
  }
}
