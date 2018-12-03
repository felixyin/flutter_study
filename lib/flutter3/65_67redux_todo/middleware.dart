import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'actions.dart';
import 'dart:async';
import 'dart:convert';

List<Middleware<AppState>> appStateMiddleware([
  AppState state,
]) {
  state = AppState(items: []);
  final loadItems = _loadFromPrefs(state);
  final saveItems = _saveToPrefs(state);

  return [
    TypedMiddleware<AppState, AddItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemAction>(saveItems),
    TypedMiddleware<AppState, RemoveItemsAction>(saveItems),
    TypedMiddleware<AppState, ItemCompletedAction>(saveItems),
    TypedMiddleware<AppState, GetItemsAction>(loadItems),
  ];
}

Middleware<AppState> _loadFromPrefs(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    loadFromPrefs().then((state) {
      store.dispatch(LoadedItemsAction(state.items));
    });

  };
}

Middleware<AppState> _saveToPrefs(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    saveToPrefs(store.state);
  };
}

void saveToPrefs(AppState state) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = json.encode(state.toJson());
  await preferences.setString('itemsState', string);
}

Future<AppState> loadFromPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  // preferences.remove('itemsState');
  // return;
  var string = preferences.getString('itemsState');
  if (string != null) {
    Map map = json.decode(string);
    return AppState.fromJson(map);
  }
  return AppState.initState();
}
