import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'package:async/async.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> _list = List<dynamic>();
  // final StreamController<dynamic> _streamController = StreamController<dynamic>();

  @override
  void initState() {
    setupData();
    super.initState();
  }

  @override
  void dispose() {
    // _streamController?.close();
    super.dispose();
  }

  void setupData() async {
    final ad = await getAllData()
      ..asBroadcastStream();
    // ad.listen((data) {
    //   _streamController.sink.add(data);
    // });
    //  _streamController.addStream(ad);
    //  _streamController.sink.addStream(ad);
    ad.listen((data) {
      setState(() {
        _list.add(data[0]); // photo
        _list.add(data[1]); // post
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Type Stream'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            final data = _list[index];
            if (data is Photo) {
              return _buildPhotoTile(data);
            } else if (data is Post) {
              return _buildPostTile(data);
            }
          },
        ),
        // child: StreamBuilder(
        //         stream: _streamController.stream,
        //         builder: (BuildContext context, AsyncSnapshot snapshot) {
        //           if (snapshot.hasError) {
        //             return Center(
        //               child: Text('error'),
        //             );
        //           } else if (snapshot.hasData) {
        //             final data = snapshot.data;
        //             print(data.length);
        //             final photo = data[0];
        //             final post = data[1];
        //             return Column(
        //               children: <Widget>[
        //                 _buildPhotoTile(photo),
        //                 _buildPostTile(post),
        //               ],
        //             );
        //           } else {
        //             return SizedBox(
        //               height: 50,
        //               child: Center(
        //                 child: Text('no data.'),
        //               ),
        //             );
        //           }
        //         },
        //       ),
      ),
    );
  }

  ListTile _buildPostTile(Post data) {
    return ListTile(
      title: Text(data.title),
      subtitle: Text(data.body),
    );
  }

  ListTile _buildPhotoTile(Photo data) {
    return ListTile(
      title: Text(data.title),
      subtitle: Image.network(data.url),
    );
  }
}

Future<Stream> getAllData() async {
  Client client = Client();
  final photos = await fetchPhotos(client);
  final posts = await fetchPosts(client);
  return StreamZip([photos, posts]).asBroadcastStream();
}

Future<Stream> fetchPhotos(Client client) async {
  final String url = 'https://jsonplaceholder.typicode.com/photos';
  Request req = Request('get', Uri.parse(url));
  StreamedResponse sr = await client.send(req);
  return sr.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((e) => e)
      .map((map) => Photo.fromJson(map));
}

Future<Stream> fetchPosts(Client client) async {
  final String url = 'https://jsonplaceholder.typicode.com/posts';
  Request req = Request('get', Uri.parse(url));
  StreamedResponse sr = await client.send(req);
  return sr.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((e) => e)
      .map((map) => Post.fromJson(map));
}

class Photo {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  Photo.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({this.userId, this.id, this.title, this.body});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
