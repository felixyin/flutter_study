import 'package:flutter/foundation.dart';

class Item {
  final int id;
  final String body;

  Item({
    @required this.id,
    @required this.body,
  });

  Item copyWith({int id, String body}) {
    return Item(id: id ?? this.id, body: body ?? this.body);
  }
}

class AppState {
  final List<Item> items;

  AppState({@required this.items});

// 实例化一个不可变的list
  AppState.initState() : items = List.unmodifiable(<Item>[]);
}
