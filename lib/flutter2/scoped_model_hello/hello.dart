import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MaterialApp(
      // home: HelloApp1(
      home: HelloApp2(
        model: new CounterModel(),
      ),
    ));

class CounterModel extends Model {
  int count = 0;

  int get counter => count;

  increment() {
    count++;
    notifyListeners(); // touch event
  }
}

class HelloApp extends StatefulWidget {
  final CounterModel model;

  const HelloApp({Key key, @required this.model}) : super(key: key);

  @override
  _HelloAppState createState() => _HelloAppState();
}

class _HelloAppState extends State<HelloApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CounterModel>(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Scoped Model Hello'),
        ),
        body: Container(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              children: <Widget>[
                // 这个Counter
                ScopedModelDescendant<CounterModel>(
                  builder: (BuildContext context, Widget child, CounterModel model) {
                    return Text(
                        'count example 1: ' + model?.counter.toString());
                  },
                ),
                Text('count example 2: ' + widget.model?.counter.toString()),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            widget.model?.increment();
          },
          child: Icon(Icons.plus_one),
        ),
      ),
      model: widget.model,
    );
  }
}

class HelloApp2 extends StatelessWidget {
  final CounterModel model;
  const HelloApp2({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CounterModel>(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Scoped Model Hello2'),
        ),
        body: Container(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              children: <Widget>[
                // 这个Counter
                ScopedModelDescendant<CounterModel>(
                  builder:
                      (BuildContext context, Widget child, CounterModel model) {
                    return Text(
                        'count example 1: ' + model?.counter.toString());
                  },
                ),
                Text('count example 2: ' + model?.counter.toString()),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model?.increment();
          },
          child: Icon(Icons.plus_one),
        ),
      ),
      model: model,
    );
  }
}
