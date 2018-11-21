import 'package:flutter/material.dart';
import 'setting.dart';
import 'login.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends State<MainApp> {
  String _title;
  Widget _body;
  bool _isLogin;

  Login _login;
  Setting _setting;

  _MainState() {
    this._title = 'Setting';
    _login = Login(
      onSubmit: () {
        _onLoginSubmit();
      },
    );
    _setting = Setting();
    _body = _login;
    this._isLogin = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Test',
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                _goToSetting();
              },
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _goToLogin();
              },
            ),
          ],
        ),
        body: _body,
      ),
    );
  }

  void _goToSetting() {
    print('go to Setting');
    auth();
  }

  void _goToLogin() {
    print('go to Login');
    this._isLogin = false;
    auth();
  }

  void _onLoginSubmit() {
    print('submiting ...');
    if (this._login.username == 'a' && this._login.password == 'b') {
      this._isLogin = true;
      print('login successful!');
      auth();
    } else {
      this._isLogin = false;
      print('login failed!');
      auth();
    }
  }

  /**
   * 将类似代码抽出为函数
   */
  void auth() {
//    print(this._login.username);
//    print(this._login.password);
//    print(this._isLogin);
    if (this._isLogin) {
      this._title = 'Setting';
      this._body = this._setting;
    } else {
      this._title = 'Login';
      this._body = this._login;
    }
    setState(() {});
  }
}
