import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _images = <String>[
    'assets/images/wallpaper-1.jpg',
    'assets/images/wallpaper-2.jpg',
    'assets/images/wallpaper-3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gradients PageView'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: SizedBox.fromSize(
          size: Size.fromHeight(500),
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.9),
            itemCount: this._images.length,
            itemBuilder: _buildItemPage,
          ),
        ),
      ),
    );
  }

  Widget _buildItemPage(BuildContext context, int index) {
    Image image = Image.asset(
      this._images[index],
      fit: BoxFit.cover,
    );

    DecoratedBox linearGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: <Color>[
            Color(0x00000000).withOpacity(0.8),
            Color(0xff000000).withOpacity(0.01),
          ],
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 16.0,
      ),
      child: Material(
        elevation: 6.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            image,
            linearGradient,
          ],
        ),
      ),
    );
  }
}
