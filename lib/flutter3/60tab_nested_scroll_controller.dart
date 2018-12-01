import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController?.dispose();
    super.dispose();
  }

  Widget _buildTabCtl() {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab Nested Scroll Controller Example'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home), text: '主页'),
              Tab(icon: Icon(Icons.sentiment_dissatisfied), text: '二页'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            TwoPage(),
          ],
        ),
      ),
      length: 2,
    );
  }

  Widget _buildNestedTabScroll() {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            title: Text('Tab Nested Scroll Controller Example'),
            pinned: true,
            floating: true,
            forceElevated: innerBoxIsScrolled,
            bottom: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.home), text: '主页'),
                Tab(icon: Icon(Icons.sentiment_dissatisfied), text: '二页'),
              ],
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          HomePage(),
          TwoPage(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Tab Nested Scroll Controller Example'),
      // ),
      // body: _buildTabCtl(),
      body: _buildNestedTabScroll(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _tabController.animateTo(1,
              curve: Curves.bounceInOut, duration: Duration(milliseconds: 2000));
          // _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          // curve: Curves.decelerate, duration: Duration(milliseconds: 1000));
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        },
        child: Icon(Icons.toll),
      ),
    );
  }
}

class TwoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemExtent: 250,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Colors.lightBlue[500],
            child: Center(
              child: Text('test... $index'),
            ),
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: <Widget>[
        Image.asset('assets/images/wallpaper-1.jpg'),
        SizedBox(
          height: 8,
        ),
        Image.asset('assets/images/wallpaper-2.jpg'),
        SizedBox(
          height: 8,
        ),
        Image.asset('assets/images/wallpaper-3.jpg'),
      ],
    );
  }
}
