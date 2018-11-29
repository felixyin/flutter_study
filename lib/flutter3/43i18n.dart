import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MaterialApp(
    title: 'I18N demo',
    theme: ThemeData(
      primaryColor: Colors.blue,
    ),
    localizationsDelegates: [
      FlutterI18nDelegate(false, 'en', 'assets/i18n'),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _currentLanguage = 'en';
  int _checked = 0;

  _changeLanguage() {
    setState(() {
      this._currentLanguage = this._currentLanguage == 'en' ? 'it' : 'en';
    });
  }

  _increment() {
    setState(() {
      this._checked += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'title')),
      ),
      body: Builder(
        builder: (BuildContext gcontext) {
          return Container(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(FlutterI18n.translate(
                      context, 'label.main', Map.fromIterables(['user'], ['FelixYin']))),
                  Text(FlutterI18n.plural(context, 'clicked.times', _checked)),
                  FlatButton(
                    child: Text(FlutterI18n.translate(context, 'button.clickMe')),
                    onPressed: _increment,
                  ),
                  FlatButton(
                    child: Icon(Icons.translate),
                    onPressed: () async {
                      _changeLanguage();
                      await FlutterI18n.refresh(context, _currentLanguage);
                      Scaffold.of(gcontext)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          content: Text(FlutterI18n.translate(context, 'toastMessage')),
                        ));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
