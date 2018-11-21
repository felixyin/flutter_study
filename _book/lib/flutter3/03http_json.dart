import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'http_json/starships.dart';
import 'http_json/results.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _url = "https://swapi.co/api/starships";
  Starships _starships;

  @override
  void initState() {
    super.initState();
    this.initData();
  }

  void initData() async {
    http.Response res = await http.get(_url);
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);
      var resultJson = json.decode(res.body);
      this.setState(() {
        this._starships = Starships.fromJson(resultJson);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HttpJson'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: this._buildListView(),
      ),
    );
  }

  ListView _buildListView() {
    if (this._starships != null && this._starships.results.length > 0) {
      final Iterable<ListTile> tiles =
          this._starships.results.map((Results result) {
        return ListTile(
          title: Text(result.name),
          subtitle: Text(result.model),
          onTap: () {
            print(result.cargoCapacity);
          },
        );
      });
      final List<Widget> divideTiles =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return ListView(
        children: divideTiles,
      );
    } else {
      return ListView(
        children: <Widget>[Text('no data')],
      );
    }
    // // return ;
    // return ListView.builder(
    //   itemCount: _starships == null ? 0 : _starships.results.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     Results result = _starships.results[index];
    //     return ListTile(
    //       title: Text(result.name),
    //       subtitle: Text(result.model),
    //     );
    //   },
    // );
  }
}
