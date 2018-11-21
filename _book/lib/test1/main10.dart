import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = List<ListItem>.generate(100, (i) {
      bool isHead = (i % 6 == 0);
      if (isHead) {
        return HeadingItem("head$i");
      } else {
        return MessageItem("sender$i", "body-body-body-body-body-body$i");
      }
    });
    return MaterialApp(
        title: "样式列表",
        home: MyList(
          items: items,
        ));
  }
}

class MyList extends StatefulWidget {
  final List<ListItem> items;

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
      body: ListView.separated(
        itemCount: widget.items.length,
        itemBuilder: (context, i) {
          final item = widget.items[i];
          if (item is HeadingItem) {
            return ListTile(
              title: Text(
                item.heading,
                style: Theme.of(context).textTheme.title,
              ),
            );
          } else if (item is MessageItem) {
            return ListTile(
              title: Text(item.sender),
              subtitle: Text(item.body),
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
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
