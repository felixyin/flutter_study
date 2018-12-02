import 'model.dart';
import 'actions.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    items: itemReducer(state.items, action),
  );
}

List<Item> itemReducer(List<Item> state, action) {
  if (action is AddItemAction) {
    if (action.item.isNotEmpty && action.item.trim().isNotEmpty) {
      return []
        ..addAll(state)
        ..add(Item(id: action.id, body: action.item));
    }
  } else if (action is RemoveItemAction) {
    return List.unmodifiable(List.from(state)..remove(action.item));
  } else if (action is RemoveItemsAction) {
    return List.unmodifiable([]);
  }
  return state;
}
