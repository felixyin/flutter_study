import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Random _random = Random();
  Color _color;

  Color _randomColor() {
    return Color.fromRGBO(
      _random.nextInt(255),
      _random.nextInt(255),
      _random.nextInt(255),
      _random.nextDouble(),
    );
  }

  void _onTap() {
    setState(() {
      this._color = _randomColor();
    });
  }

  @override
  void initState() {
    super.initState();
    this._color = _randomColor();
  }

  @override
  Widget build(BuildContext context) {
    print('call root build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Inherited Widget'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: BorderDirectional(
                top: BorderSide(
          // color: this._color,
          width: 20.0,
        ))),
        child: Center(
          child: ColorState(
            color: _color,
            onTap: _onTap,
            child: ColorTree(),
          ),
        ),
      ),
    );
  }
}

class ColorTree extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ColorTreeState();
  }
}

class _ColorTreeState extends State<ColorTree> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ColorBox(),
        ColorBox(),
      ],
    );
  }
}

class ColorBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = ColorState.of(context);
    return GestureDetector(
      onTap: cs.onTap,
      child: Container(
        color: cs.color,
        padding: EdgeInsets.all(50.0),
        child: Text('tap this'),
      ),
    );
  }
}

///
/// 为了防止rerender从root节点开始，InheritedWidget可以解决这个问题
///
class ColorState extends InheritedWidget {
  final Color color;
  final Function onTap;

  ColorState({Key key, @required this.color, this.onTap, @required Widget child})
      : assert(color != null),
        assert(onTap != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(ColorState oldColorState) {
    print('call updateShouldNotify');
    return oldColorState.color != this.color; // 请在这里添加断点，测试rebuild是否是从根结点开始的？
  }

  static ColorState of(BuildContext context) {
    print('call ColorState of');
    return context.inheritFromWidgetOfExactType(ColorState);
  }
}
