import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FirstPage'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text(
                'first page',
                style: TextStyle(fontSize: 20.0),
              ),
              RaisedButton(
                child: Text('Go Second Page'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/SecondPage');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
