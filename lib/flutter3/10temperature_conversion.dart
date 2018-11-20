import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isFahrenheit = true;
  double _value;

  @override
  Widget build(BuildContext context) {
    TextField textFiled = TextField(
      decoration: InputDecoration(
        labelText: '请输入' + (_isFahrenheit ? '摄氏温度' : '华氏温度'),
      ),
      onChanged: (value) {
        this._value = double.tryParse(value); // 这里不需要setState
      },
      keyboardType: TextInputType.number,
    );

    Widget switchWidget;
    // switchWidget = Container(
    //   margin: EdgeInsets.all(10.0),
    //   child: Column(
    //     children: <Widget>[
    //       Text('切换温度单位'),
    //       Switch(
    //         onChanged: (bool value) {
    //           setState(() {
    //             this._isFahrenheit = !this._isFahrenheit;
    //           });
    //         },
    //         value: this._isFahrenheit,
    //       ),
    //     ],
    //   ),
    // );

    // switchWidget = Container(
    //   margin: EdgeInsets.all(10.0),
    //   child: Column(
    //     children: <Widget>[
    //       Text(this._isFahrenheit ? '华氏温度' : '摄氏温度'),
    //       Checkbox(
    //         onChanged: (bool value) {
    //           setState(() {
    //             this._isFahrenheit = !this._isFahrenheit;
    //           });
    //         },
    //         value: this._isFahrenheit,
    //       )
    //     ],
    //   ),
    // );

    switchWidget = Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Text('转换为华氏温度'),
          Radio<bool>(
            groupValue: this._isFahrenheit,
            onChanged: (bool value) {
              setState(() {
                this._isFahrenheit = value;
              });
            },
            value: true,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text('转换为摄氏温度'),
          Radio<bool>(
            groupValue: this._isFahrenheit,
            onChanged: (bool value) {
              setState(() {
                this._isFahrenheit = value;
              });
            },
            value: false,
          ),
        ],
      ),
    );

    Widget calBtn = Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: RaisedButton(
          color: Colors.blueAccent,
          colorBrightness: Brightness.dark,
          onPressed: () {
            if (this._value == null || this._value.isNaN) {
              print('请输入要转换的温度数值');
              return;
            }
            double wenDu = this._isFahrenheit == false
                ? (this._value - 32) * (5 / 9)
                : (this._value * 9 / 5) + 32;
            String wenDuStr = wenDu.toStringAsFixed(2);
            print(wenDuStr);

            showDialog(
                child: AlertDialog(
                  content: Text((_isFahrenheit ? '摄氏温度' : '华氏温度') +
                      '转换为' +
                      (_isFahrenheit ? '华氏温度' : '摄氏温度') +
                      '是：$wenDuStr'),
                ),
                context: context);
          },
          child: Text('计算'),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Conversion'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              textFiled,
              switchWidget,
              calBtn,
            ],
          ),
        ),
      ),
    );
  }
}
