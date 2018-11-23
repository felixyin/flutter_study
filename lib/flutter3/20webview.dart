import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// String URL = 'https://youtube.com/';
// TODO 这里只能用https吗？？？？
String URL = 'https://www.baidu.com/';

void main() => runApp(MaterialApp(
      // home: MyApp(),
      theme: ThemeData.light(),
      routes: {
        '/': (_) => MyApp(),
        '/webview': (_) => WebviewScaffold(
              url: URL,
              appBar: new AppBar(
                title: const Text('Widget webview'),
              ),
              withZoom: true,
              withLocalStorage: true,
              hidden: false,
              initialChild: Container(
                color: Colors.redAccent,
                child: const Center(
                  child: Text('Waiting.....'),
                ),
              ),
            ),
      },
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _controller;

  final _webviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
   
    super.initState();
    this._webviewPlugin.close();
    this._controller = TextEditingController(text: URL);
    this._controller.addListener(() {
      URL = this._controller.text;
    });
  }

  @override
  void dispose() {
    this._webviewPlugin?.dispose();
    this._controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webview Demo'),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _controller,
              ),
              RaisedButton(
                onPressed: _lauchUrl2,
                child: Text('打开地址'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _lauchUrl1() async {
    if (await canLaunch(URL)) {
      await launch(
        URL,
        enableJavaScript: true,
        forceSafariVC: true,
        forceWebView: true,
        statusBarBrightness: Brightness.light,
      );
    } else {
      throw 'url不能被打开';
    }
  }

  void _lauchUrl2() async {
    Navigator.of(context).pushNamed('/webview');
  }

  void _lauchUrl3() async {
    this._webviewPlugin.launch(URL);
    Navigator.of(context).pushNamed('/webview');
  }
}
