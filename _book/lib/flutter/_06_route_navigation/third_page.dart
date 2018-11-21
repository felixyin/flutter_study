import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ThirdPage'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text(
                'third page',
                style: TextStyle(fontSize: 20.0),
              ),
              RaisedButton(
                child: Text('Back'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                child: Text('Go First Page'),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/FirstPage', (context) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
