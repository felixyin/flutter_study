import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'sample.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String url = 'http://www.yinbin.ink/static/post.json';
  List<Sample> list = List<Sample>();
  bool isError = false;

  _initData() async {
    try {
      http.Response res = await http.get(url);
      String body = res.body;
      List<dynamic> jsonList = json.decode(body);
      List<Sample> list = jsonList.map((d) {
        return Sample.fromJson(d);
      }).toList();
      setState(() {
        this.list = list;
      });
    } catch (e) {
      print('>>>>>>>' + e.toString());
      setState(() {
        this.isError = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this._initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http test'),
      ),
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    if (this.isError) {
      return Center(
        child: Text(
          'error...',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
    }
    if (this.list.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: this.list.length,
        itemBuilder: (BuildContext context, int index) {
          Sample sample = this.list[index];
          return _buildListTile(sample, index);
        },
      );
    }
  }

  Column _buildListTile(Sample sample, int index) {
    List<Widget> _rows = <Widget>[
      ListTile(
        title: Text(sample.title),
        subtitle: Text(sample.body),
        trailing: Icon(Icons.launch),
        onTap: () {
          print(sample.userId);
        },
      ),
      Divider(),
    ];
    if (index == this.list.length - 1) {
      _rows.removeLast();
    }
    return Column(children: _rows);
  }
}
