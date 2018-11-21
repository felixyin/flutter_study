import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path/path.dart' as path;
import 'dart:io';
import 'dart:convert';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _keyController;
  TextEditingController _valueController;
  Map<String, dynamic> _map;

  String _showText;

  @override
  void initState() {
    super.initState();
    _keyController = TextEditingController();
    _valueController = TextEditingController();
    _map = Map<String, dynamic>();
    _showText = '';
    _readMapFromFile();
  }

  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Storage Example'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('显示手机文件中的内容：'),
              Text(
                this._showText,
                maxLines: 10,
              ),
              Container(padding: EdgeInsets.all(10)),
              TextField(
                decoration: InputDecoration(
                  hintText: 'key',
                ),
                controller: _keyController,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'value',
                ),
                controller: _valueController,
              ),
              RaisedButton(
                onPressed: _onSaveBtnClicked,
                child: Text('保存'),
              ),
              RaisedButton(
                onPressed: _onCleanBtnClicked,
                child: Text('清空'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveMapToFile(Map<String, dynamic> map) async {
    try {
      Directory docDir = await pathProvider.getApplicationDocumentsDirectory();
      String distPath = docDir.path + path.separator + 'test.json';
      File file = File(distPath);
      if (!file.existsSync()) {
        file.createSync();
      }
      String contents = json.encode(map);
      file.writeAsStringSync(contents);
    } catch (e) {
      print(e.toString());
    }
  }

  void _readMapFromFile() {
    pathProvider.getApplicationDocumentsDirectory().then((Directory docDir) {
      String distPath = docDir.path + path.separator + 'test.json';
      File file = File(distPath);
      if (file.existsSync()) {
        file.createSync();
        String contents = file.readAsStringSync();
        this._map = json.decode(contents);
        this._setShowText();
      }
    });
  }

  void _setShowText() {
    setState(() {
      this._showText = json.encode(this._map);
    });
  }

  void _onSaveBtnClicked() {
    String key = this._keyController.text.trim().replaceAll(' ', '_');
    String value = this._valueController.text.trim();
    if (key.isEmpty || value.isEmpty) {
      print('warn: 不能空着');
      return;
    }

    this._map.update(key, (oldValue) => value, ifAbsent: () => value);
    this._setShowText();
    this._saveMapToFile(this._map);
  }

  void _onCleanBtnClicked() {
    this._saveMapToFile(this._map..clear());
    this._setShowText();
  }
}
