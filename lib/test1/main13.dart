import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final title = "滑动列表";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: MyHome(title: title),
    );
  }
}

class MyHome extends StatelessWidget {
  final String title;

  MyHome({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final items = List<int>.generate(50, (i) => i);
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: MyList(items: items),
    );
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
    return ListView.separated(
      itemCount: widget.items.length,
      itemBuilder: _buildItem,
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  Widget _buildItem(context, i) {
    int key = widget.items[i];
    return Dismissible(
      key: Key(key.toString()),
      child: ListTile(
        title: Text(
          "滑动列表：$key",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (d) {
        setState(() {
          widget.items.removeAt(i);
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("您删除了\"滑动列表：$key\"")));
        });
      },
    );
  }
}
