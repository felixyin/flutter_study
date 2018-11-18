import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController _tabController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
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
        title: Text('TabBar3'),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: 'One',
              icon: Icon(Icons.offline_bolt),
            ),
            Tab(
              text: 'Two',
              icon: Icon(Icons.tab),
            ),
            Tab(
              text: 'Three',
              icon: Icon(Icons.theaters),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            title: Text('One'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tab),
            title: Text('Two'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.theaters),
            title: Text('Three'),
          ),
        ],
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
          });
        },
      ),
      //  打开这里，看两种效果
      // body: TabBarView(
      //   controller: _tabController,
      //   children: _body,
      // ),
      body: _body[this._currentIndex],
    );
  }

  List<Widget> _body = <Widget>[
    Tab1(),
    Tab2(),
    Tab3(),
  ];
}

class Tab3 extends StatefulWidget {
  _Tab3State createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Icon(Icons.theaters),
      ),
    );
  }
}

class Tab2 extends StatefulWidget {
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Icon(Icons.tab),
      ),
    );
  }
}

class Tab1 extends StatefulWidget {
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Icon(Icons.offline_bolt),
      ),
    );
  }
}
