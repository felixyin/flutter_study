import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

void main(List<String> args) {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final ThemeData iosTheme = ThemeData(
    primaryColor: Colors.blue[400],
    primarySwatch: Colors.green,
    accentColor: Colors.red,
    accentColorBrightness: Brightness.dark,
  );

  final ThemeData androidTheme = ThemeData(
    primaryColor: Colors.red,
    primarySwatch: Colors.blue,
    accentColor: Colors.lightBlueAccent,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTargetPlatform == TargetPlatform.iOS ? iosTheme : androidTheme,
      home: ChatApp(),
    );
  }
}

class ChatApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChatWin();
  }
}

final String defaultUserName = '尹彬';

class ChatWin extends State<ChatApp> with TickerProviderStateMixin {
  TextEditingController _controller = TextEditingController();
  List<MsgRow> _msgList = List<MsgRow>();
  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('聊天室'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 6.0,
      ),
      body: Container(
        margin: EdgeInsets.all(6.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _msgList.length,
                reverse: true,
                itemBuilder: (context, index) => _msgList[index],
                padding: EdgeInsets.all(6.0),
              ),
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              child: _buildComposer(),
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        padding: EdgeInsets.all(3.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: (String value) {
                  setState(() {
                    this._isWriting = value.length > 0;
                  });
                },
                onSubmitted: _onSubmitMsg, // enter
                // 修改完毕，保存后，实时预览
                decoration: InputDecoration.collapsed(hintText: 'type something in here...'),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? CupertinoButton(
                      child: Text('发送'),
                      onPressed: _isWriting ? () => _onSubmitMsg(_controller.text) : null,
                    )
                  : IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _isWriting ? () => _onSubmitMsg(_controller.text) : null,
                    ),
            ),
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1.0,
                    color: Colors.brown,
                  ),
                ),
              )
            : null,
      ),
    );
  }

  void _onSubmitMsg(String msg) {
    _controller.clear();
    if (msg.isEmpty) return;
    MsgRow msgRow = MsgRow(
      msg: msg,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1200),
      ),
    );
    setState(() {
      _msgList.insert(0, msgRow);
      _isWriting = false;
    });
    msgRow.animationController.forward();
  }

  @override
  void dispose() {
    _msgList.forEach((msgRow) => msgRow.animationController.dispose());
    super.dispose();
  }
}

class MsgRow extends StatelessWidget {
  const MsgRow({
    Key key,
    @required this.msg,
    @required this.animationController,
  }) : super(key: key);

  final AnimationController animationController;
  final String msg;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(curve: Curves.elasticOut, parent: animationController),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 15.0),
              child: CircleAvatar(
                // backgroundColor: Theme.of(context).accentColor,
                child: Text(defaultUserName[0]),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(defaultUserName, style: Theme.of(context).textTheme.subhead),
                  Container(
                    margin: EdgeInsets.only(top: 6.0),
                    child: Text(msg),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
