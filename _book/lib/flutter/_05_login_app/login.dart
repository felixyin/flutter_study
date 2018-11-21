import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final VoidCallback onSubmit;

  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Login({
    Key key,
    @required this.onSubmit,
  }) : super(key: key);

  String get username => _userController.text;
  String get password => _passwordController.text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(35.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _userController,
              decoration: InputDecoration(
                labelText: 'Please enter username',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Please enter password',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          RaisedButton(
            child: Text('login'),
            onPressed: () {
              onSubmit();
            },
          )
        ],
      ),
    );
  }
}
