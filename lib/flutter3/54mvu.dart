import 'package:flutter/material.dart';
import 'package:dartea/dartea.dart';

void main() {
  final program = Program<TodoModel, Message, Null>(init, update, view, subscription: null);
  runApp(MyApp(program));
}

class MyApp extends StatelessWidget {
  final Program program;
  MyApp(this.program);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVU hello',
      home: program.build(),
    );
  }
}

class TodoModel {
  final String todo;
  final List<String> todos;
  TodoModel(this.todo, this.todos);
  TodoModel copyWith({String todo, List<String> todos}) =>
      TodoModel(todo ?? this.todo, todos ?? todos);
}

abstract class Message {}

class AddTodo implements Message {
  final String todo;
  AddTodo(this.todo);
}

class RemoveTodo implements Message {
  final int index;
  RemoveTodo(this.index);
}

class ClearTodo implements Message {}

Upd<TodoModel, Message> init() {
  return Upd(TodoModel('', []));
}

Upd<TodoModel, Message> update(Message msg, TodoModel model) {
  if (msg is AddTodo) {
    if (msg.todo.isNotEmpty) {
      return Upd(model.copyWith(
        todo: msg.todo,
        todos: model.todos..add(msg.todo),
      ));
    }
  } else if (msg is RemoveTodo) {
    return Upd(model.copyWith(
      todos: model.todos..removeAt(msg.index),
    ));
  } else if (msg is ClearTodo) {
    return Upd(model.copyWith(todo: '', todos: model.todos..clear()));
  }
  return Upd(model);
}

Widget view(BuildContext ctx, dispatch, TodoModel model) {
  return new Home(ctx: ctx, dispatch: dispatch, model: model);
}

class Home extends StatelessWidget {
  final BuildContext ctx;
  final dispatch;
  final TodoModel model;

  Home({
    Key key,
    @required this.ctx,
    @required this.dispatch,
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('MVU DEMO'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller,
              decoration: InputDecoration(hintText: 'type something...'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    dispatch(AddTodo(controller.text));
                  },
                  child: Text('Add'),
                ),
                RaisedButton(
                  onPressed: () {
                    dispatch(ClearTodo());
                  },
                  child: Text('Clear'),
                )
              ],
            ),
            Flexible(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(model.todos[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        dispatch(RemoveTodo(index));
                      },
                    ),
                  );
                },
                itemCount: model.todos.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
