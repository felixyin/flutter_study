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
        title: Text('Animation Loader'),
      ),
      body: Container(child: Center(child: MyLoader())),
    );
  }
}

class MyLoader extends StatefulWidget {
  @override
  _MyLoaderState createState() => _MyLoaderState();
}

class _MyLoaderState extends State<MyLoader>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _animation = CurvedAnimation(curve: Curves.easeInOut, parent: _controller);
    _animation.addListener(() {
      this.setState(() {});
    });
    _controller.repeat();
  }

  @override
    void dispose() {
      _controller.dispose(); // 记得controller需要随着一起释放掉
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 2.0),
          height: 3,
          width: this._animation.value * 40,
          color: Colors.blue[200],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 2.0),
          height: 3,
          width: this._animation.value * 35,
          color: Colors.blue[200],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 2.0),
          height: 3,
          width: this._animation.value * 30,
          color: Colors.blue[200],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 2.0),
          height: 3,
          width: this._animation.value * 25,
          color: Colors.blue[200],
        ),
      ],
    );
  }
}
