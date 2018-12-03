import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'model.dart';
import 'actions.dart';
import 'reduceres.dart';
import 'middleware.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DevToolsStore<AppState> store = DevToolsStore<AppState>(
      appStateReducer,
      initialState: AppState.initState(),
      middleware: appStateMiddleware(),
      distinct: true,
    );

    return StoreProvider<AppState>(
      child: MaterialApp(
        // theme: ThemeData.dark(),
        home: StoreBuilder<AppState>(
          onInit: (store) => store.dispatch(GetItemsAction()),
          builder: (BuildContext context, Store<AppState> vm) => HomePage(
                store: vm,
              ),
        ),
      ),
      store: store,
    );
  }
}

class HomePage extends StatelessWidget {
  final DevToolsStore<AppState> store;

  const HomePage({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        // color: Colors.blueAccent,
        child: ReduxDevTools<AppState>(store),
      ),
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
        leading: Checkbox(
          value: item.completed,
          onChanged: (b) {
            widget.vm.onCompleted(item);
          },
        ),
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
  _ViewModel({this.items, this.onAddItem, this.onRemoveItem, this.onRemoveItems, this.onCompleted});

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

    _onCompleted(Item item) {
      store.dispatch(ItemCompletedAction(item));
    }

    return _ViewModel(
      items: store.state.items,
      onAddItem: _onAddItem,
      onRemoveItem: _onRemoveItem,
      onRemoveItems: _onRemoveItems,
      onCompleted: _onCompleted,
    );
  }

  final List<Item> items;

  final Function(String) onAddItem;

  final Function(Item item) onRemoveItem;

  final Function() onRemoveItems;

  final Function(Item item) onCompleted;
}
