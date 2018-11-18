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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LifeCycle'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[Text('life cycle.')],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('=========' + 'initState');
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print('=========' + 'dispose');
    super.dispose();
  }

  AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
    print('=========' + state.toString());
    switch (state) {
      case AppLifecycleState.inactive:
        print('=========' + 'inactive');
        break;
      case AppLifecycleState.paused:
        print('=========' + 'paused');
        break;
      case AppLifecycleState.resumed:
        print('=========' + 'resumed');
        break;
      case AppLifecycleState.suspending:
        print('=========' + 'suspending');
        break;
      default:
    }
  }
}
