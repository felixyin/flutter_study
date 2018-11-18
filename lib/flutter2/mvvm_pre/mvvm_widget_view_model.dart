import 'package:flutter/material.dart';
import './mvvm_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './sample.dart';

abstract class MvvmWidgetViewModel extends State<MvvmWidget> {
  final String url = 'http://www.yinbin.ink/static/post.json';
  List<Sample> list = List<Sample>();
  bool isError = false;

  @protected
  initData() async {
    try {
      http.Response res = await http.get(url);
      String body = res.body;
      List<dynamic> jsonList = json.decode(body);
      List<Sample> list = jsonList.map((d) {
        return Sample.fromJson(d);
      }).toList();
      setState(() {
        this.list = list;
      });
    } catch (e) {
      print('>>>>>>>' + e.toString());
      setState(() {
        this.isError = true;
      });
    }
  }
}
