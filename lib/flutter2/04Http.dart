import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        title: Text('Http test'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: _fetchJsonFromHttp,
                child: Text('http json'),
              ),
              RaisedButton(
                onPressed: _fetchJsonFromHttp1,
                child: Text('http json1'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _fetchJsonFromHttp() async {
    http.Response response =
        await http.get('https://jsonplaceholder.typicode.com/posts');
    // print(response.body);

    List list = json.decode(response.body);
    print(list[0]['title']);
  }

  void _fetchJsonFromHttp1() {
    Future<http.Response> response =
        http.get('https://jsonplaceholder.typicode.com/posts');
    // print(response.body);
    response.then((res) {
      List list = json.decode(res.body);
      print(list[0]['title']);
    });

  }
}
