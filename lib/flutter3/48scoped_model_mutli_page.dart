import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(new MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.fallback(),
      home: TabPageExample(
        itemModel: ItemModel(),
      ),
    );
  }
}

class TabPageExample extends StatefulWidget {
  final ItemModel itemModel;
  const TabPageExample({Key key, @required this.itemModel}) : super(key: key);
  @override
  TabPageExampleState createState() => TabPageExampleState();
}

class TabPageExampleState extends State<TabPageExample> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ItemModel>(
      model: widget.itemModel,
      child: DefaultTabController(
        child: Scaffold(
          appBar: AppBar(
            title: Text('ScopedModel and MutliPage'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.home),
                  text: '首页',
                ),
                Tab(
                  icon: Icon(Icons.list),
                  text: '列表',
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBarView(
              children: <Widget>[
                HomePage(),
                ListPage(),
              ],
            ),
          ),
        ),
        length: 2,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScopedModelDescendant<ItemModel>(
        rebuildOnChange: true,
        builder: (BuildContext context, Widget child, ItemModel model) {
          return Column(
            children: <Widget>[
              TextField(
                controller: _textEditingController,
                onSubmitted: (_) => _onAddItem(model),
                decoration: InputDecoration(
                  hintText: '请输入一些文字',
                ),
              ),
              RaisedButton(
                onPressed: () => _onAddItem(model),
                child: Text('添加'),
              )
            ],
          );
        },
      ),
    );
  }

  void _onAddItem(ItemModel model) {
    model.addItem(Item(_textEditingController.text));
    setState(() {
      _textEditingController.clear();
    });
  }
}

class ListPage extends StatefulWidget {
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScopedModelDescendant<ItemModel>(
        builder: (BuildContext context, Widget child, ItemModel model) {
          Iterable<Widget> tiles = model.items.map((item) => _buildTile(item, model));
          final list = ListTile.divideTiles(tiles: tiles, context: context).toList();
          return ListView(
            children: list,
          );
        },
      ),
    );
  }

  Widget _buildTile(Item item, ItemModel model) {
    return ListTile(
      title: Text(item.text),
      onLongPress: () {
        model.removeItem(item);
      },
    );
  }
}

class Item {
  final String text;
  Item(this.text);
}

class ItemModel extends Model {
  List<Item> _items = List<Item>();

  List<Item> get items => _items;

  void addItem(Item item) {
    if (item != null && item.text.isNotEmpty) {
      this.items.add(item);
    }
  }

  void removeItem(item) {
    this.items.remove(item);
    notifyListeners();
  }
}
