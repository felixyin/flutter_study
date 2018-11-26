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

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: DefaultTabController(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Movie APP'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home Page',
                ),
                Tab(
                  icon: Icon(Icons.favorite),
                  text: 'Favorites',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Home(),
              Favorites(),
            ],
          ),
        ),
        length: 2,
      ),
    );
  }
}

class Favorites extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoritesState();
  }
}

class _FavoritesState extends State<Favorites> {
  List<MovieResult> filterdMovies = List();
  List<MovieResult> movieCache = List();

  final PublishSubject subject = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    movieCache = [];
    filterdMovies = [];
    subject.stream.listen(searchDataList);
    setupList();
  }

  void setupList() async {
    MovieDatabase db = MovieDatabase();
    filterdMovies = await db.getMovies();
    setState(() {
      movieCache = filterdMovies;
    });
  }

  @override
  void dispose() {
    subject?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (string) => subject.add(string),
            keyboardType: TextInputType.url,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filterdMovies.length,
              itemBuilder: (BuildContext context, int index) {
                MovieResult _movie = filterdMovies[index];
                return ExpansionTile(
                  initiallyExpanded: _movie.expand ?? false,
                  onExpansionChanged: (b) => _movie.expand = b,
                  leading: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _onTapDelete(index),
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
                                  child: Image.network(
                                      'https://image.tmdb.org/t/p/w92${_movie.posterPath}'),
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
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onTapDelete(int index) {
    setState(() {
      this.filterdMovies.removeAt(index);
    });
    MovieDatabase db = MovieDatabase();
    db.removeMovie(this.filterdMovies[index].id);
  }

  void searchDataList(query) {}
}

const String API_KEY = '36190e1f430fedb78e9fbe26c2bf706d';

class Home extends StatefulWidget {
  List<MovieResult> _movieList = List();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PublishSubject<String> _publishSubject;
  // TextEditingController _editingController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // _editingController = TextEditingController();
    _publishSubject = PublishSubject<String>();
    _publishSubject.stream.listen(_searchMovies);
  }

  @override
  void dispose() {
    // _editingController?.dispose();
    _publishSubject?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    // controller: _editingController,
                    // onChanged: (v) => _onTapQueryBtn(),
                    onSubmitted: (v) => _onTapQueryBtn(v),
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
                      itemCount: widget._movieList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MovieView(
                          movie: widget._movieList[index],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _onTapQueryBtn(query) {
    // String query = _editingController.text;
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
          widget._movieList.add(MovieResult.fromJson(m));
        });
      });
    });
  }

  void _resetMovies() {
    setState(() {
      widget._movieList.clear();
    });
  }
}

class MovieView extends StatefulWidget {
  final MovieResult movie;

  const MovieView({Key key, @required this.movie}) : super(key: key);

  @override
  _MovieViewState createState() {
    return new _MovieViewState();
  }
}

class _MovieViewState extends State<MovieView> {
  MovieResult _movie;

  @override
  void initState() {
    super.initState();
    _movie = widget.movie;
    MovieDatabase db = MovieDatabase();
    db.getMovie(_movie.id).then((movie) {
      if (movie != null) {
        setState(() {
          _movie.favored = movie.favored;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: _movie.expand ?? false,
      onExpansionChanged: (b) => _movie.expand = b,
      leading: IconButton(
        icon: _movie.favored == true ? Icon(Icons.star) : Icon(Icons.star_border),
        onPressed: _onTapShouCang,
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

  void _onTapShouCang() {
    MovieDatabase db = MovieDatabase();
    setState(() => _movie.favored = !_movie.favored);
    _movie.favored == true ? db.addMovie(_movie) : db.removeMovie(_movie.id);
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
    // await File(path).delete();
    Database database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  FutureOr _onCreate(Database db, int version) async {
    // await db.execute('DROP TABLE Movie');
    await db.execute(
        'CREATE TABLE Movie(id NUM PRIMARY KEY, title TEXT, poster_path TEXT, overview TEXT, favored BIT)');
    print('====> DB created!');
  }

  Future<bool> isMovieSaved(int id) async {
    Database d = await db;
    List list = await d.query('Movie', where: 'id=?', whereArgs: [id]);
    print('isMovieSaved =========================> $list');
    return list != null && list.length == 0;
  }

  Future<List<MovieResult>> getMovies() async {
    Database d = await db;
    List<Map> list = await d.query('Movie');
    print('movies =========================> $list');
    return list.map((row) => MovieResult.fromDB(row)).toList();
  }

  Future<MovieResult> getMovie(int id) async {
    Database d = await db;
    final res = await d.query('Movie', where: 'id=?', whereArgs: [id]);
    print('movie =========================> $res');
    if (res.length == 0) return null;
    return MovieResult.fromDB(res[0]);
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
