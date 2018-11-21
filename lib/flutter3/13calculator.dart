import 'package:flutter/material.dart';

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
        title: Text('Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(0.0),
        child: Column(
          children: <Widget>[
            _buildResultRow(),
            _buildButtonsPanel(),
          ],
        ),
      ),
    );
  }

  _buildResultRow() {
    return Expanded(
      flex: 13,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        color: Colors.blueGrey.withOpacity(0.5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '23+81',
              // textDirection: TextDirection.rtl,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildButtonsPanel() {
    return Expanded(
      flex: 50,
      child: Column(
        children: <Widget>[
          _makeBtns('C<%/'),
          _makeBtns('789x'),
          _makeBtns('456-'),
          _makeBtns('123+'),
          _makeBtns('_0.='),
        ],
      ),
    );
  }

  _makeBtns(String s) {
    List<String> btnListStr = s.split('');
    final btns = btnListStr.map((btnStr) {
      return new CalBtn(
        btnStr: btnStr,
      );
    }).toList();
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: btns,
      ),
    );
  }
}

class CalBtn extends StatelessWidget {
  final String btnStr;

  CalBtn({
    Key key,
    @required this.btnStr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: FlatButton(
        color: Colors.white,
        shape: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
          style: BorderStyle.solid,
        ),
        child: Text(
          btnStr,
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 30,
            color: Colors.black45,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
