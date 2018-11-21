import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SecondPage'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text(
                'second page',
                style: TextStyle(fontSize: 20.0),
              ),
              RaisedButton(
                child: Text('Back'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                child: Text('Go Third Page'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/ThirdPage');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
