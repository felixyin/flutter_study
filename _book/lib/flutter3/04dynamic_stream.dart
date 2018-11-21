import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'album.dart';
import 'dart:async';
import 'dart:convert';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _url = 'https://jsonplaceholder.typicode.com/photos';
  List<Album> _albums = <Album>[];
  StreamController<Album> _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<Album>.broadcast();
    _streamController.stream.listen((Album album) {
      this.setState(() {
        this._albums.add(album);
      });
    });
    _load(_streamController);
  }

  @override
  void dispose() {
    _streamController?.close();
    _streamController = null;
    super.dispose();
  }

  void _load(StreamController<Album> streamCtl) async {
    http.Client client = http.Client();
    http.Request request = http.Request('get', Uri.parse(_url));
    http.StreamedResponse streamResp = await client.send(request);

    streamResp.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((e) => e)
        .map((m) => Album.fromJson(m))
        .pipe(streamCtl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DynamicStreamList'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: _buildElement,
        ),
      ),
    );
  }

  Widget _buildElement(BuildContext context, int index) {
    if (index >= _albums.length) {
      return null;
    }
    return Container(
      padding: EdgeInsets.all(10.0),
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Column(
          children: <Widget>[
            Image.network(
              _albums[index].url,
              // height: 200.0,
              // width: 200.0,
            ),
            Text(
              _albums[index].title,
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
