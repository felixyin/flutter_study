import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'movie_model/movie_model.dart';
import 'movie_model/movie_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  MovieModel _movieModel;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
    _publishSubject = PublishSubject<String>();
    _publishSubject.stream.listen(_searchMovies);
  }

  @override
  void dispose() {
    _editingController?.dispose();
    _publishSubject?.close();
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
                  // RaisedButton(
                  //   onPressed: _onTapQueryBtn,
                  //   child: Text('搜索'),
                  // ),
                ],
              ),
              (_movieModel == null || _movieModel.results == null)
                  ? CircularProgressIndicator()
                  : Expanded(
                      child: MovieView(movieModel: _movieModel),
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
    http
        .get('https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&query=$query')
        .then((http.Response res) {
      String body = res.body;
      final map = json.decode(body);
      MovieModel model = MovieModel.fromJson(map);
      setState(() {
        this._movieModel = model;
      });
    });
  }
}

class MovieView extends StatelessWidget {
  const MovieView({
    Key key,
    @required MovieModel movieModel,
  })  : _movieModel = movieModel,
        super(key: key);

  final MovieModel _movieModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _movieModel.results.length,
      itemBuilder: (BuildContext context, int index) {
        MovieResult movieResult = _movieModel.results[index];
        return _buildCard(movieResult);
      },
    );
  }

  Card _buildCard(MovieResult movieResult) {
    return Card(
      child: Container(
        height: 150,
        child: Row(
          children: <Widget>[
            movieResult.posterPath == null
                ? Container()
                : Hero(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child:
                          Image.network('https://image.tmdb.org/t/p/w92${movieResult.posterPath}'),
                    ),
                    tag: movieResult.id,
                  ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(movieResult.title),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: movieResult.favored ? Icon(Icons.star) : Icon(Icons.star_border),
                      onPressed: () {},
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.file_download),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
