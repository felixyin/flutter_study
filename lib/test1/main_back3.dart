import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '单词本',
      home: RandomWords(),
      theme: ThemeData(primaryColor: Colors.blueGrey),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _words = List<WordPair>();
  final TextStyle _largerFont = TextStyle(fontSize: 18.0);
  final Set<WordPair> _saveds = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("单词本"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.list,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: _pushWords,
          )
        ],
      ),
      body: _buildWords(),
    );
  }

  Widget _buildWords() {
    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return Divider();
          }
          final int index = i ~/ 2;
          if (index <= _words.length) {
            _words.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_words[index]);
        });
  }

  Widget _buildRow(WordPair word) {
    bool alreadySaved = _saveds.contains(word);
    return ListTile(
      title: Text(
        word.asPascalCase,
        style: _largerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saveds.remove(word);
          } else {
            _saveds.add(word);
          }
        });
      },
    );
  }

  void _pushWords() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      final Iterable<ListTile> tiles = _saveds.map((word) {
        return ListTile(
          title: Text(
            word.asPascalCase,
            style: _largerFont,
          ),
        );
      });
      final List<Widget> listItems =
          ListTile.divideTiles(context: ctx, tiles: tiles).toList();
      return Scaffold(
        appBar: AppBar(
          title: Text("收藏本"),
        ),
        body: ListView(
          children: listItems,
        ),
      );
    }));
  }
}
