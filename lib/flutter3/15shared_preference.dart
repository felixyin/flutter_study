import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String _prefs_key = 'my_list1';

  TextEditingController _controller;
  List<String> _oneList, _twoList;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _oneList = [];
    _twoList = [];
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getTwoListFromSP();
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preference'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: '请输入要保存的内容.',
              ),
            ),
            RaisedButton(
              onPressed: _addItem,
              child: Text('增加'),
            ),
            RaisedButton(
              onPressed: _clearItem,
              child: Text('清除全部'),
            ),
            Flex(
              mainAxisAlignment: MainAxisAlignment.start,
              direction: Axis.vertical,
              children: _twoList == null
                  ? []
                  : _twoList.map((String s) {
                      return Dismissible(
                        key: Key(s),
                        child: ListTile(
                          title: Text(s),
                        ),
                        onDismissed: (dd) => _removeItem(s),
                      );
                    }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _getTwoListFromSP() {
    _prefs.then((SharedPreferences prefs) {
      _twoList = prefs.getStringList(_prefs_key);
      setState(() {});
    });
  }

  void _removeItem(String key) async {
    SharedPreferences sp = await _prefs;
    _oneList.remove(key);
    _twoList.remove(key);
    sp.setStringList(_prefs_key, _oneList);
    setState(() {});
  }

  void _clearItem() async {
    _oneList.clear();
    _twoList.clear();
    SharedPreferences prefs = await _prefs;
    prefs.clear();
    setState(() {});
  }

  void _addItem() {
    _oneList.add(_controller.text);
    _controller.clear();
    _prefs.then((SharedPreferences prefs) {
      prefs.setStringList(_prefs_key, _oneList);
      setState(() {});
    });
  }
}
