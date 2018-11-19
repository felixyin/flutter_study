import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<ScaffoldState> _globalScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();

  bool _isLogined = false;
  String _username, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._globalScaffoldKey,
      appBar: AppBar(
        title: Text('GlobalKey State Validate'),
      ),
      body: this._isLogined == false
          ? this._buildLoginForm()
          : this._buildHomePage(),
    );
  }

  Container _buildLoginForm() {
    String _validateNotNullAndLen(value, String labelText) {
      if (value.isEmpty) {
        return '${labelText}不能为空';
      }
      if (value.length < 6) {
        return '${labelText}长度不能小于6';
      }
      return null;
    }

    void _onSubmit() {
      final form = this._globalFormKey.currentState;
      if (form.validate()) {
        form.save(); // call the save method on the TextFormField
        print('login success!!!');
        setState(() {
          // 实际情况中，需要访问网络
          this._isLogined = true;
        });
        SnackBar snackbar = SnackBar(
          content: Text('username:${_username},password:${_password}'),
          duration: Duration(milliseconds: 5000),
        );
        this._globalScaffoldKey.currentState.hideCurrentSnackBar();
        this._globalScaffoldKey.currentState.showSnackBar(snackbar);
      }
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Form(
        key: this._globalFormKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) => _validateNotNullAndLen(value, '用户名'),
              onSaved: (value) => this._username = value,
              decoration: InputDecoration(
                labelText: '用户名',
              ),
            ),
            TextFormField(
              obscureText: true,
              validator: (value) => _validateNotNullAndLen(value, '密码'),
              onSaved: (value) => this._password = value,
              decoration: InputDecoration(
                labelText: '密码',
              ),
            ),
            RaisedButton(
              onPressed: _onSubmit,
              color: Colors.lightBlueAccent,
              child: Text('登录'),
            ),
          ],
        ),
      ),
    );
  }

  _buildHomePage() {
    void _onBackToLoginBtnClicked() {
      setState(() {
        this._isLogined = false;
      });
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Login info:${_username},${_password}'),
            IconButton(
              color: Colors.lightBlueAccent,
              icon: Icon(Icons.arrow_back),
              onPressed: _onBackToLoginBtnClicked,
            ),
          ],
        ),
      ),
    );
  }
}
