import 'model.dart';

class AddItemAction {
  static int _id = 0;
  final String item;

  AddItemAction(this.item) {
    _id += 1;
  }

  int get id => _id;
  @override
  String toString() {
    return super.toString() + ': ' + id.toString() + ',' + item;
  }
}

class RemoveItemAction {
  RemoveItemAction(this.item);

  final Item item;
  @override
  String toString() {
    return super.toString() + ': ' + item.toString();
  }
}

class RemoveItemsAction {}

class GetItemsAction {}

class LoadedItemsAction {
  LoadedItemsAction(this.items);

  final List<Item> items;
}

class ItemCompletedAction {
  ItemCompletedAction(this.item);

  final Item item;
}
