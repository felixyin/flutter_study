import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final title = "网络请求";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final futurePost = _fetchPosts();
    return Scaffold(
      appBar: AppBar(
        title: Text("网络请求例子"),
      ),
      body: Center(
        child: FutureBuilder<Post>(
          future: futurePost,
          builder: (future, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.title);
            } else if (snapshot.hasError) {
              return Text(snapshot.error);
            }

            return LinearProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<Post> _fetchPosts() async {
  final http.Response response =
      await http.get("https://jsonplaceholder.typicode.com/posts/1");
  final j = json.decode(response.body);
  return Post.formJson(j);
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.formJson(Map<String, dynamic> json) {
    return Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"]);
  }
}
