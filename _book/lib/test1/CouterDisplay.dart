import 'package:flutter/material.dart';

class CouterDisplay extends StatelessWidget {
  int count = 0;
  CouterDisplay(this.count);

  @override
  Widget build(BuildContext context) {
    return Text("count:$count");
  }
}
