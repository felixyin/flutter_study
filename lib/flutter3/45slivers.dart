import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slives Demo'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // title: Center(
            //   child: Text(
            //     'This is a Title.',
            //     style: TextStyle(
            //       color: Colors.red,
            //       fontSize: 30.0,
            //       decoration: TextDecoration.underline,
            //     ),
            //   ),
            // ),
            expandedHeight: 250,
            // elevation: 50,
            pinned: true,
            floating: true,
            snap: false,
            forceElevated: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/wallpaper-1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.cake), text: '左侧'),
                Tab(icon: Icon(Icons.golf_course), text: '右侧'),
              ],
               controller: TabController(length: 2, vsync: this),
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.purple[100 * (index % 9)],
                  child: Text('Grid item:$index'),
                );
              },
              childCount: 20,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
          ),
          SliverFillViewport(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                child: Text('Sliver Fill Viewport'),
                color: Colors.lightBlue,
              );
            }, childCount: 2),
          ),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.indigo[100 * (index % 9)],
                child: Text('List Item: $index'),
              );
            }, childCount: 10),
            itemExtent: 90.0, // 固定item高度
          ),
        ],
      ),
    );
  }
}
