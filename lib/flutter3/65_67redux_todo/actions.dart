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
  LoadedItemsAction(this.items) {
    // 初始化子增长id，防止id重新从0开始后数据添加出现重复id
    AddItemAction._id = this.items == null ? 0 : this.items.last.id;
  }
  final List<Item> items;
}

class ItemCompletedAction {
  ItemCompletedAction(this.item);

  final Item item;
}
