import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  // 显示电脑图片
  // Injector.configure(RepoType.MOCK);

  // 显示颜色块
  Injector.configure(RepoType.PROD);

  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Injector _injector;
  @override
  void initState() {
    super.initState();
    _injector = Injector();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Actor And Inject'),
        ),
        body: FutureBuilder(
          future: _injector.photoRepo.fetchPhotos(http.Client()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? PhotoGrid(photos: snapshot.data)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }
}

class PhotoGrid extends StatelessWidget {
  final List<Photo> photos;

  const PhotoGrid({Key key, this.photos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
      ),
      itemCount: photos.length,
      itemBuilder: (BuildContext context, int index) {
        try {
          return Image.network(photos[index].url);
        } catch (e) {
          return Container();
        }
      },
    );
  }
}

enum RepoType { MOCK, PROD }

class Injector {
  static final Injector _singleton = Injector._internal();
  factory Injector() {
    return _singleton;
  }
  Injector._internal();
  static RepoType _repoType;
  static void configure(RepoType repoType) {
    _repoType = repoType;
  }

  PhotoRepo get photoRepo {
    PhotoRepo pr;
    switch (_repoType) {
      case RepoType.MOCK:
        pr = MockRepo();
        break;
      case RepoType.PROD:
        pr = ProdRepo();
        break;
      default:
        pr = MockRepo();
        break;
    }
    return pr;
  }
}

class Photo {
  final int id;
  final String title;
  final String url;

  Photo({this.id, this.title, this.url});

  factory Photo.fromJson(Map<String, dynamic> map) {
    return Photo(
      id: map['id'],
      title: map['title'],
      url: map['url'],
    );
  }
}

abstract class PhotoRepo {
  Future<List<Photo>> fetchPhotos(http.Client client);
}

class ProdRepo extends PhotoRepo {
  String _url = 'https://jsonplaceholder.typicode.com/photos';
  @override
  Future<List<Photo>> fetchPhotos(http.Client client) async {
    final response = await client.get(_url);
    return compute(parseJson, response.body);
  }
}

List<Photo> parseJson(String respBody) {
  final parsed = json.decode(respBody);
  return parsed.map<Photo>((p) => Photo.fromJson(p)).toList();
}

class MockRepo extends PhotoRepo {
  @override
  Future<List<Photo>> fetchPhotos(http.Client client) {
    /// TODO 线程通讯 compute，开启一个新的线程执行
    /// 在某个操作需要执行大量的计算或者io操作的时候，可能会影响界面流畅度，所以需要另开一个“线程”处理这部分任务
    return compute(createPhotos, 400);
  }
}

List<Photo> createPhotos(int count) {
  return List.generate(
    count,
    (i) => Photo(
          id: i,
          title: 'title$i',
          url: 'https://placeimg.com/640/480/tech/$i',
        ),
  );
}
