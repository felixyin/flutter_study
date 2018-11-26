import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'movie_model/movie_result.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

void main() => runApp(MaterialApp(
      theme: ThemeData.dark(),
      home: MovieList(),
    ));

const String API_KEY = '36190e1f430fedb78e9fbe26c2bf706d';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  PublishSubject<String> _publishSubject;
  TextEditingController _editingController;
  List<MovieResult> _movieList;
  MovieDatabase _database;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
    _publishSubject = PublishSubject<String>();
    _publishSubject.stream.listen(_searchMovies);
    _movieList = List();
    _database = MovieDatabase();
    _database.initDB();
  }

  @override
  void dispose() {
    _editingController?.dispose();
    _publishSubject?.close();
    _database?.closeDB();
    _movieList = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Rxdart'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _editingController,
                      // onChanged: (v) => _onTapQueryBtn(),
                      onSubmitted: (v) => _onTapQueryBtn(),
                      decoration: InputDecoration(hintText: '请输入想看的影片'),
                    ),
                  ),
                ],
              ),
              _isLoading
                  ? Padding(
                      child: CircularProgressIndicator(),
                      padding: EdgeInsets.only(top: 40.0),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _movieList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MovieView(
                            movie: _movieList[index],
                            db: _database,
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapQueryBtn() {
    String query = _editingController.text;
    if (query.isNotEmpty) {
      _publishSubject.add(query);
    }
  }

  void _searchMovies(String query) {
    // print(movieModel.toJson().toString());
    _resetMovies();
    setState(() {
      this._isLoading = true;
    });
    http
        .get('https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&query=$query')
        .then((http.Response res) {
      String body = res.body;
      List map = json.decode(body)["results"];
      setState(() {
        this._isLoading = false;
      });
      map.forEach((m) {
        setState(() {
          this._movieList.add(MovieResult.fromJson(m));
        });
      });
    });
  }

  void _resetMovies() {
    setState(() {
      this._movieList.clear();
    });
  }
}

class MovieView extends StatefulWidget {
  final MovieResult movie;
  final MovieDatabase db;

  const MovieView({Key key, @required this.movie, @required this.db}) : super(key: key);

  @override
  _MovieViewState createState() {
    return new _MovieViewState();
  }
}

class _MovieViewState extends State<MovieView> {
  MovieResult _movie;
  MovieDatabase _db;

  @override
  void initState() {
    super.initState();
    _movie = widget.movie;
    _db = widget.db;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: _movie.expand ?? false,
      onExpansionChanged: (b) => _movie.expand = b,
      leading: IconButton(
        icon: _movie.favored == true ? Icon(Icons.star) : Icon(Icons.star_border),
        onPressed: () {
          setState(() => _movie.favored = !_movie.favored);
          _movie.favored == true ? _db.addMovie(_movie) : _db.removeMovie(_movie.id);
        },
      ),
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          child: RichText(
            text: TextSpan(
              text: _movie.overview,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        )
      ],
      title: Container(
        height: 150,
        child: Row(
          children: <Widget>[
            _movie.posterPath == null
                ? Container()
                : Hero(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Image.network('https://image.tmdb.org/t/p/w92${_movie.posterPath}'),
                    ),
                    tag: _movie.id,
                  ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(_movie.title),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
///sqlite数据库管理对象
///
class MovieDatabase {
  MovieDatabase._internal();
  static MovieDatabase _instance = MovieDatabase._internal();
  factory MovieDatabase() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    // var databasesPath = await getDatabasesPath();
    Directory databasesPath = await getApplicationDocumentsDirectory();
    String path = join(databasesPath.path, "movie.db");
    // await deleteDatabase(path);
    Database database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  FutureOr _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Movie(id STRING PRIMARY KEY, title TEXT, poster_path TEXT, overview TEXT, favored BIT)');
    print('====> DB created!');
  }

  Future<bool> isMovieSaved(int id) async {
    Database d = await db;
    List list = await d.query('Movie', where: 'id=?', whereArgs: [id]);
    print('isMovieSaved =========================> $list');
    return list != null && list.length == 1;
  }

  Future<int> addMovie(MovieResult movieResult) async {
    if (await isMovieSaved(movieResult.id)) {
      Database d = await db;
      int count = await d.insert('Movie', movieResult.toMap());
      print('insert =========================> $count');
      return count;
    } else {
      return updateMovie(movieResult, movieResult.id);
    }
  }

  Future<int> updateMovie(MovieResult movieResult, int id) async {
    Database d = await db;
    Map<String, dynamic> map = movieResult.toMap();
    map.remove('id');
    int count = await d.update('Movie', map, where: 'id=?', whereArgs: [id]);
    print('update =========================> $id $count');
    return count;
  }

  Future<int> removeMovie(int id) async {
    Database d = await db;
    int count = await d.delete('Movie', where: 'id=?', whereArgs: [id]);
    print('count =========================> $count');
    return count;
  }

  Future closeDB() async {
    Database d = await db;
    return await d.close();
  }
}
