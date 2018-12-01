import 'example_plugin.dart';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _versionStr = '';
  String _randomStr = '';

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  void _initPlatformState() {
    ExamplePlugin.platformVersion.then((v) {
      // 要显示到的组件，可能会被异步的方法给删除掉
      if (!mounted) return; 
      setState(() {
        _versionStr = v;
      });
    });
    ExamplePlugin.randomString.then((v) {
      if (!mounted) return;
      setState(() {
        _randomStr = v;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native Plugin'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_versionStr),
              Text(_randomStr),
            ],
          ),
        ),
      ),
    );
  }
}
