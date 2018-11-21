import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    _animation = Tween(begin: 0.0, end: 200.0)
        .chain(CurveTween(curve: Curves.bounceInOut))
        .animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    _animationController.forward();
    // _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: new LogoAnimation(animation: _animation),
    );
  }
}

class LogoAnimation extends StatelessWidget {
  const LogoAnimation({
    Key key,
    @required Animation animation,
  }) : _animation = animation, super(key: key);

  final Animation _animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this._animation.value,
        height: this._animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}
