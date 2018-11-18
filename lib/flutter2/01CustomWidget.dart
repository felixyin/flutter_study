import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MyCard(
                title: 'Hello',
                iconData: Icons.favorite,
              ),
              MyCard(
                title: '时间',
                iconData: Icons.access_time,
              ),
              MyCard(
                title: '账号',
                iconData: Icons.account_box,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final String title;
  final IconData iconData;

  const MyCard({Key key, this.title, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(this.title,style: TextStyle(fontSize: 22.0),),
              Icon(
                this.iconData,
                size: 50.0,
              ),
            ],
          ),
        ),
        semanticContainer: true,
        margin: EdgeInsets.all(5.0),
      ),
    );
  }
}
