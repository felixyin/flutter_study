import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'model.dart';
import 'actions.dart';
import 'reduceres.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = Store<AppState>(
      appStateReducer,
      initialState: AppState.initState(),
    );

    return StoreProvider<AppState>(
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: HomePage(),
      ),
      store: store,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redux TODO'),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel vm) {
          return Column(
            children: <Widget>[
              AddItemWidget(
                vm: vm,
              ),
              Expanded(child: ItemListWidget(vm: vm)),
              RemoveItemsButton(vm: vm),
            ],
          );
        },
      ),
    );
  }
}

class RemoveItemsButton extends StatefulWidget {
  final _ViewModel vm;
  const RemoveItemsButton({Key key, this.vm}) : super(key: key);
  _RemoveItemsButtonState createState() => _RemoveItemsButtonState();
}

class _RemoveItemsButtonState extends State<RemoveItemsButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        widget.vm.onRemoveItems();
      },
      child: Text('Clear All'),
    );
  }
}

class ItemListWidget extends StatefulWidget {
  final _ViewModel vm;

  const ItemListWidget({Key key, @required this.vm}) : super(key: key);
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.vm.items.map(_buildItem).toList(),
    );
  }

  ListTile _buildItem(Item item) => ListTile(
        title: Text(item.body),
        trailing: IconButton(
          onPressed: () {
            widget.vm.onRemoveItem(item);
          },
          icon: Icon(Icons.delete),
        ),
      );
}

class AddItemWidget extends StatefulWidget {
  final _ViewModel vm;

  const AddItemWidget({Key key, this.vm}) : super(key: key);
  _AddItemWidgetState createState() => _AddItemWidgetState();
}

class _AddItemWidgetState extends State<AddItemWidget> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      onSubmitted: (value) {
        widget.vm.onAddItem(value);
        _textEditingController.clear();
      },
    );
  }
}

class _ViewModel {
  _ViewModel({this.items, this.onAddItem, this.onRemoveItem, this.onRemoveItems});

  factory _ViewModel.create(Store<AppState> store) {
    _onAddItem(String body) {
      store.dispatch(AddItemAction(body));
    }

    _onRemoveItem(Item item) {
      store.dispatch(RemoveItemAction(item));
    }

    _onRemoveItems() {
      store.dispatch(RemoveItemsAction());
    }

    return _ViewModel(
      items: store.state.items,
      onAddItem: _onAddItem,
      onRemoveItem: _onRemoveItem,
      onRemoveItems: _onRemoveItems,
    );
  }

  final List<Item> items;

  final Function(String) onAddItem;

  final Function(Item item) onRemoveItem;

  final Function() onRemoveItems;
}
