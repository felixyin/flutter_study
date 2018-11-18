import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String _text;

  _MyAppState() {
    this._text = '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello',
      home: Scaffold(
        key: _globalKey,
        appBar: AppBar(
          title: Text('TextField'),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) => _onTextFieldChanged(value),
                      onEditingComplete: () => _onButtonClick(),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    // textColor: Colors.white,
                    textTheme: ButtonTextTheme.primary,
                    child: Text(
                      '点击',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    onPressed: () => _onButtonClick(),
                  ),
                ],
              ),
              SizedBox(
                height: 120,
                child: Card(
                  color: Colors.lightBlue[100],
                  elevation: 5.0,
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            this._text,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextField(
                onChanged: (value) => _onTextFieldChanged(value),
                maxLines: 3,
                textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  labelText: '请输入您的简介',
                  // hintText: '张三？',
                  icon: Icon(
                    Icons.details,
                    size: 80.0,
                  ),
                  border: OutlineInputBorder(
                      gapPadding: 5.0,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide(color: Colors.red, width: 6.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onButtonClick() {
    print(this._text);

    _globalKey.currentState.hideCurrentSnackBar();
    _globalKey.currentState.showSnackBar(SnackBar(
      content: Text(this._text),
    ));
  }

  _onTextFieldChanged(String value) {
    setState(() {
      this._text = value;
    });
  }
}
