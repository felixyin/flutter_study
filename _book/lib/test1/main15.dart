import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final title = "传递数据";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: ListPage(),
    );
  }
}

class ListPage extends StatelessWidget {
  static String title = "传递数据演示";
  final List<Todo> todos = List<Todo>.generate(50, (i) {
    return Todo(
      title: "这里是标题:$i",
      description: "这里是内容！！！！！$i",
    );
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ListPage.title),
      ),
      body: ListView.separated(
        itemBuilder: (context, i) {
          final Todo t = this.todos[i];
          return ListTile(
            title: Text(t.title),
            onTap: () {
              _navPageWaitResult(context, t);
            },
          );
        },
        separatorBuilder: (context, i) {
          return Divider();
        },
        itemCount: this.todos.length,
      ),
    );
  }

  void _navPageWaitResult(BuildContext context, Todo t) async {
    final result =
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DetailPage(todo: t);
    }));
    result.then((v) {
      print(v);
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("你在详情页面点击了:$v")));
    });
  }
}

class DetailPage extends StatelessWidget {
  final Todo todo;

  const DetailPage({Key key, this.todo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.todo.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(this.todo.description),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text("Nope."),
                onPressed: () {
                  Navigator.of(context).pop("Nope.");
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text("Yep!"),
                onPressed: () {
                  Navigator.of(context).pop("Yep!");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Todo {
  final String title;
  final String description;

  Todo({Key key, @required this.title, @required this.description});
}
