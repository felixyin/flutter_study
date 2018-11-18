import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class AppModel extends Model {
  AppModel() {
    _list = List<String>();
  }

  String _text;
  List<String> _list;

  String get text => _text;

  void addText(String text) {
    if (text.isNotEmpty) {
      _text = text;
      if (!_list.contains(_text)) {
        _list.add(_text);
        notifyListeners();
      }
    }
  }

  List<String> get list => _list;
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AppModel _appModel;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _appModel = AppModel();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mutli Page Scoped Model'),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home),
              text: 'Home',
            ),
            Tab(
              icon: Icon(Icons.list),
              text: 'List',
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: ScopedModel<AppModel>(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                HomePage(),
                ListPage(),
              ],
            ),
            model: _appModel,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: '请输入一些文字!'),
          ),
          ScopedModelDescendant<AppModel>(
            rebuildOnChange: false,
            builder: (BuildContext context, Widget child, AppModel model) {
              return RaisedButton(
                onPressed: () => _onSaveBtnClicked(model),
                child: Text('保存'),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onSaveBtnClicked(AppModel model) {
    print('save...');
    print(_controller.text);
    model.addText(_controller.text);
  }
}

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScopedModelDescendant<AppModel>(
        builder: (BuildContext context, Widget child, AppModel model) {
          return ListView.builder(
            itemCount: model.list.length,
            itemBuilder: (BuildContext context, int index) {
              String text = model.list[index];
              List<Widget> row = <Widget>[
                ListTile(
                  title: Text(text),
                ),
              ];
              if (index < model.list.length - 1) {
                row.add(Divider());
              }
              return Column(
                children: row,
              );
            },
          );
        },
      ),
    );
  }
}
