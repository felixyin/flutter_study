import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:math' as math;

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class CalModel extends Model {
  String prevValue;
  String currentValue;
  String opt;
  String result;
  bool isHoldBtn = false;
  CalModel({this.prevValue, this.currentValue, this.opt, this.result});

  void num(String btnStr) {
    this.currentValue += btnStr;
    this.result = this.currentValue;
    this.isHoldBtn = false; // 其他按钮的点击都取消高亮效果
    notifyListeners();
  }

  void _showResult(var result) {
    double resultDouble = 0.0;
    if (result.runtimeType == String) {
      resultDouble = double.parse(result);
    } else if (result.runtimeType == double) {
      resultDouble = result;
    }
    int resultInt = resultDouble.toInt();
    this.result = this.currentValue = (resultInt == resultDouble) ? resultInt.toString() : resultDouble.toString();
  }

  void cal(String btnStr) {
    this.isHoldBtn = false; // 其他按钮的点击都取消高亮效果
    switch (btnStr) {
      case "C":
        this.prevValue = '';
        this.currentValue = '';
        this.result = '0';
        break;
      case ".":
        if (!this.currentValue.contains('.')) {
          this.currentValue += '.';
        }
        break;
      case "<":
        int len = this.currentValue.length;
        if (len == 1) {
          _showResult('0');
        } else {
          _showResult(this.currentValue.substring(0, len - 1));
        }
        break;
      case "_":
        double cv = double.parse(this.currentValue);
        if (cv > 0.0) {
          _showResult('-$cv');
        } else if (cv < 0.0) {
          _showResult(cv.abs());
        }
        break;
      case "%":
      case "x":
      case "+":
      case "-":
      case "/":
        this.prevValue = this.currentValue;
        this.opt = btnStr;
        this.currentValue = '';
        this.isHoldBtn = true;
        break;
      case "=":
        double pv = double.parse(this.prevValue);
        double nv = double.parse(this.currentValue);
        switch (this.opt) {
          case "x":
            _showResult(pv * nv);
            break;
          case "+":
            _showResult(pv + nv);
            break;
          case "-":
            _showResult(pv - nv);
            break;
          case "/":
            _showResult(pv / nv);
            break;
          case "%":
            _showResult(pv % nv);
            break;
        }
        break;
      default:
    }
    notifyListeners();
  }

  bool isWillHold(String btnStr) {
    return btnStr == opt && this.isHoldBtn;
  }
}

class MyApp extends StatefulWidget {
  CalModel calModel = CalModel(prevValue: '', currentValue: '', opt: '', result: '0');
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
        child: ScopedModel<CalModel>(
          child: Column(
            children: <Widget>[
              _buildResultRow(),
              _buildButtonsPanel(),
            ],
          ),
          model: widget.calModel,
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
            ScopedModelDescendant<CalModel>(
              builder: (BuildContext context, Widget child, CalModel model) {
                return Text(
                  model.result,
                  // textDirection: TextDirection.rtl,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                );
              },
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

  bool _isNumber(String btnStr) {
    return double.tryParse(btnStr) != null;
  }

  void _onBtnClick(CalModel model, String btnStr) {
    if (_isNumber(btnStr)) {
      //按下的数字按钮
      model.num(btnStr);
    } else {
      // 按下的非数字按钮
      model.cal(btnStr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ScopedModelDescendant<CalModel>(
        rebuildOnChange: true,
        builder: (BuildContext context, Widget child, CalModel model) {
          Color color = Colors.white;
          if (model.isWillHold(btnStr)) {
            color = Colors.blueGrey[200].withOpacity(0.7);
          }
          return FlatButton(
            color: color,
            shape: Border.all(color: Colors.grey.withOpacity(0.5), width: 1.0, style: BorderStyle.solid),
            child: Text(
              btnStr,
              style: TextStyle(fontStyle: FontStyle.normal, fontSize: 30, color: Colors.black45),
            ),
            onPressed: () => _onBtnClick(model, btnStr),
          );
        },
      ),
    );
  }
}
