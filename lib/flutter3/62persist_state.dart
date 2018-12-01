import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currNavIdx = 0;
  List<Widget> _pages;
  Widget _currPage;

  final List<Data> _datas = List<Data>();

  @override
  void initState() {
    super.initState();

    // 生成测试数据
    List.generate(30, (n) => _datas.add(Data(n, false, 'title-$n')));

    final onePage = OnePage(datas: _datas);
    final twoPage = TwoPage();
    _currPage = onePage;
    _pages = [onePage, twoPage];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persist State'),
      ),
      body: _currPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currNavIdx,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('OnePage'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.open_with),
            title: Text('TwoPage'),
          ),
        ],
        onTap: (idx) {
          setState(() {
            _currNavIdx = idx;
            _currPage = _pages[idx];
          });
        },
      ),
    );
  }
}

class Data {
  Data(this.id, this.expanded, this.title);

  /// 此expaned可以修改
  bool expanded;

  final int id;
  final String title;
}

class OnePage extends StatefulWidget {
  final List<Data> datas;
  const OnePage({Key key, this.datas}) : super(key: key);
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        Data data = widget.datas[index];
        return ExpansionTile(
          key: PageStorageKey(data.id),
          title: Text(data.title),
          // initiallyExpanded: data.expanded,
          // onExpansionChanged: (value) {
          //   data.expanded = value;
          //   PageStorage.of(context).writeState(
          //     context,
          //     value,
          //     identifier: ValueKey(data.id),
          //   );
          // },
          children: <Widget>[
            Container(
              color: index % 2 == 0 ? Colors.redAccent : Colors.blueAccent,
              height: 150,
            ),
          ],
        ); 
      },
      itemCount: widget.datas.length,
    );
  }
}

class TwoPage extends StatefulWidget {
  _TwoPageState createState() => _TwoPageState();
}

class _TwoPageState extends State<TwoPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(8.0),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(8.0),
            color: index % 2 == 0 ? Colors.black38 : Colors.white12,
            child: Center(
              child: Text('test..$index'),
            ),
          ),
        );
      },
    );
  }
}
