import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

void main(List<String> args) {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test',
      home: HomeApp(
        storage: Storage(), // 松耦合，方便切换存储方式
      ),
    );
  }
}

class HomeApp extends StatefulWidget {
  final Storage storage;

  HomeApp({Key key, @required this.storage}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeAppState();
  }
}

class _HomeAppState extends State<HomeApp> {
  TextEditingController _textEditingController;
  String _text;
  Future<Directory> _appDocDir;

  @override
  void initState() {
    super.initState();
    this._textEditingController = TextEditingController();
    widget.storage.readData().then((value) {
      setState(() {
        this._text = value;
      });
    });
  }

  @override
  void dispose() {
    this._textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read and Write Data'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('${this._text}'),
            TextField(
              controller: this._textEditingController,
            ),
            RaisedButton(
              onPressed: _wirteData,
              child: Text('Write data'),
            ),
            RaisedButton(
              onPressed: _showPath,
              child: Text('Show path'),
            ),
            FutureBuilder<Directory>(
              future: this._appDocDir,
              builder: (BuildContext context, AsyncSnapshot<Directory> snapshot) {
                String dir = '';
                if (snapshot.hasError) {
                  dir = 'error:' + snapshot.error;
                } else if (snapshot.hasData) {
                  dir = snapshot.data.path;
                } else {
                  dir = 'prease press the buttton "Show path"';
                }
                return Container(
                  child: Text(dir),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showPath() async {
    setState(() {
      this._appDocDir = getApplicationDocumentsDirectory();
    });
  }

  void _wirteData() async {
    setState(() {
      this._text = this._textEditingController.text;
    });
    widget.storage.writeData(this._text);
  }
}

class Storage {
  Future<String> localPath() async {
    Directory dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> localFile() async {
    String path = await localPath();
    return File('$path/db.txt');
  }

  Future<String> readData() async {
    try {
      File file = await localFile();
      return file.readAsString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data) async {
    File file = await localFile();
    return file.writeAsString(data);
  }
}
