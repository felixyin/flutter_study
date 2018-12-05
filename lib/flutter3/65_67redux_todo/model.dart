import 'package:flutter/foundation.dart';

class Item {
  final int id;
  final String body;
  final bool completed;

  Item({
    @required this.id,
    @required this.body,
    this.completed = false,
  });

  Item copyWith({int id, String body, bool completed}) {
    return Item(
      id: id ?? this.id,
      body: body ?? this.body,
      completed: completed ?? this.completed,
    );
  }

  Item.fromJson(Map json)
      : id = json['id'],
        body = json['body'],
        completed = json['completed'];

  Map toJson() => {
        'id': id,
        'body': body,
        'completed': completed,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class Note {
  final int id;
  final String title;
  final String content;
  final DateTime lastTime;

  Note({
    this.id,
    this.title,
    this.content,
    this.lastTime,
  });

  Note copyWith({int id, String title, String content, DateTime lastTime}) {
    return Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        lastTime: lastTime ?? this.lastTime);
  }

  Note.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        lastTime = json['lastTime'];

  Map toJson() => {id: id, title: title, content: content, lastTime: lastTime};

  @override
  String toString() {
    return toJson().toString();
  }
}

class AppState {
  AppState({
    @required this.items,
    @required this.notes,
  });

  AppState.fromJson(Map json)
      : items = (json['items'] as List).map((itemJson) => Item.fromJson(itemJson)).toList(),
        notes = (json['notes'] as List).map((noteJson) => Note.fromJson(noteJson)).toList();

// 实例化一个不可变的list
  AppState.initState()
      : items = List.unmodifiable(<Item>[]),
        notes = List.unmodifiable(<Note>[]);

  final List<Item> items;
  final List<Note> notes;

  @override
  String toString() {
    return toJson().toString();
  }

  Map toJson() => {'items': items, 'notes': notes};
}
