import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainAppState();
  }
}

class _MainAppState extends State<MainApp> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _controller = TextEditingController(text: '');

  String _text = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello',
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('snack bar'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '请输入一些提示语句.',
                  ),
                  onChanged: (value) {
                    // this._text = value;
                    this._text = _controller.text;
                  },
                ),
                RaisedButton(
                  onPressed: _onShowSnackBar,
                  child: Text('显示snack bar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onShowSnackBar() {
    //                error  Scaffold.of() called with a context that does not contain a Scaffold.
    //                  Scaffold.of(context).showSnackBar(SnackBar(
    //                    content: Text(this._text),
    //                  ));
    if (this._text.isNotEmpty) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(this._text),
      ));
    }
  }
}
