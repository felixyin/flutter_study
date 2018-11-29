import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WebSocketChannel _webSocketChannel;
  TextEditingController _textEditingController;
  final List<String> _list = [];

  @override
  void initState() {
    super.initState();
    _webSocketChannel = IOWebSocketChannel.connect('ws://echo.websocket.org');
    _textEditingController = TextEditingController();
    _webSocketChannel.stream.listen((data) => setState(() => _list.add(data)));
  }

  @override
  void dispose() {
    _webSocketChannel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webscokets'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Form(
                child: TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(labelText: 'type something in here.'),
                ),
              ),
              Column(
                children: _list.map((item) => Text(item)).toList(),
              ),
              // StreamBuilder(
              //   stream: _webSocketChannel.stream,
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     return Container(
              //       child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendData,
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendData() async {
    if (_textEditingController.text.isNotEmpty) {
      _webSocketChannel.sink.add(_textEditingController.text);
      _textEditingController.clear();
    }
  }
}
