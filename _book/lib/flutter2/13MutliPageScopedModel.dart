import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class AppModel extends Model {
  String text;
  List<String> list;

  AppModel() {
    list = List<String>();
  }

  void addText(String t) {
    if (t.isNotEmpty && !list.contains(t)) {
      list.add(t);
      notifyListeners();
    }
  }
}

class _MyAppState extends State<MyApp> {
  AppModel _appModel;

  final routes = <String, WidgetBuilder>{
    HomePage.route: (ctx) => HomePage(),
    ListPage.route: (ctx) => ListPage(),
  };

  @override
  void initState() {
    super.initState();
    _appModel = AppModel();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      child: MaterialApp(
        home: HomePage(),
        routes: routes,
      ),
      model: _appModel,
    );
  }
}

class HomePage extends StatelessWidget {
  static String route = '/Home';

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: '请输入项目..'),
              ),
              ScopedModelDescendant<AppModel>(
                rebuildOnChange: false,
                builder: (BuildContext context, Widget child, AppModel model) {
                  return RaisedButton(
                    onPressed: () {
                      model.addText(_controller.text);
                      _controller.clear();
                    },
                    child: Icon(Icons.add),
                  );
                },
              ),
              RaisedButton(
                onPressed: () => Navigator.of(context).pushNamed('/List'),
                child: Text('查看列表'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  static String route = '/List';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: ScopedModelDescendant<AppModel>(
            builder: (BuildContext context, Widget child, AppModel model) {
              return ListView.builder(
                itemCount: model.list.length,
                itemBuilder: (BuildContext context, int index) {
                  String text = model.list[index];
                  List<Widget> rows = <Widget>[
                    ListTile(
                      title: Text(text),
                    ),
                  ];
                  if (index < model.list.length - 1) {
                    rows.add(Divider());
                  }
                  return Column(
                    children: rows,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
