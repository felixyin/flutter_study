import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "长列表",
      home: LongList(
        items: List<String>.generate(100, (i) {
          return "text:$i";
        }),
      ),
    );
  }
}

class LongList extends StatefulWidget {
  final List<String> items;

  LongList({Key key, @required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LongListState();
  }
}

class LongListState extends State<LongList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("长列表"),
      ),
      body: ListView.separated(
        itemCount: widget.items.length,
        itemBuilder: (context, i) {
          final item = widget.items[i];
          return ListTile(
            title: Text("$item"),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            indent: 2.0,
            height: 2.0,
            color: Theme.of(context).accentColor,
          );
        },
      ),
    );
  }
}
