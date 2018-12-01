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
    return ScopedModel<ItemModel>(
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          HomePage.route: (_) => HomePage(),
          ListPage.route: (_) => ListPage(),
        },
      ),
      model: ItemModel(),
    );
  }
}

class HomePage extends StatefulWidget {
  static final route = '/HomePage';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
                  ),
                  RaisedButton(
                    onPressed: () => Navigator.pushNamed(context, ListPage.route),
                    child: Text('显示列表'),
                  )
                ],
              );
            },
          ),
        ),
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
  static final route = '/ListPage';
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('列表'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ScopedModelDescendant<ItemModel>(
            builder: (BuildContext context, Widget child, ItemModel model) {
              Iterable<Widget> tiles = model.items.map((item) => _buildTile(item, model));
              final list = ListTile.divideTiles(tiles: tiles, context: context).toList();
              return ListView(
                children: list,
              );
            },
          ),
        ),
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
