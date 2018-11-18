import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = List<int>.generate(100, (i) {
      return i;
    });
    return MaterialApp(
        title: "样式列表",
        home: MyList(
          items: items,
        ));
  }
}

class MyList extends StatefulWidget {
  final List<int> items;

  const MyList({Key key, this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyListState();
}

class MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("样式不同的列表"),
      ),
      body: Container(
        padding: EdgeInsets.all(4.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: widget.items.map((item) {
            return Container(
              child: new Text("test$item"),
              color: Colors.green,
              margin: EdgeInsets.all(4.0),
            );
          }).toList(),
        ),
      ),
    );
  }
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}
