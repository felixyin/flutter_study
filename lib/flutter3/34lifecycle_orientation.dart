import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LifeCycle Orientation'),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          // return GridView.count(
          //   crossAxisCount: orientation == Orientation.landscape ? 4 : 2,
          //   children: List.generate(10, (i) {
          //     return Text('Test $i');
          //   }),
          // );
          return Container(child: Center(child: Text('tests: $_notification'),),);
        },
      ),
    );
  }
}
