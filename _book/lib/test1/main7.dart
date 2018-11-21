import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
//  debugPaintSizeEnabled = true;
//  debugPaintPointersEnabled = true;
//  debugInstrumentationEnabled = true;
//  debugPaintBaselinesEnabled = true;
//  debugPaintLayerBordersEnabled = true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appName = 'Custom Themes';

    return new MaterialApp(
      title: appName,
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
      ),
      home: new MyHomePage(
        title: appName,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  final String url =
      "https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg";

  MyHomePage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: ListView(
        children: <Widget>[
          Image(
            image: NetworkImage(url),
            fit: BoxFit.fitWidth,
            height: 200.0,
          ),
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: url,
            fit: BoxFit.fitWidth,
            height: 200.0,
          ),
          CachedNetworkImage(
            imageUrl: url,
            placeholder: new CircularProgressIndicator(),
            errorWidget: new Icon(Icons.error),
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            fit: BoxFit.cover,
          )
        ],
      ),
      floatingActionButton: new Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.red),
        child: new FloatingActionButton(
          onPressed: null,
          child: new Icon(Icons.add),
        ),
      ),
    );
  }
}
