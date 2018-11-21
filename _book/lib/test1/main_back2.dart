import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '单词本',
      home: RandomWords(),
      theme: ThemeData(primaryColor: Colors.pink[800]),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RandomWordState();
}

class RandomWordState extends State<RandomWords> {
  final List<WordPair> _words = <WordPair>[];
  final TextStyle _largerFont = TextStyle(fontSize: 18.0);
  final Set<WordPair> _saveds = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("单词本"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildWords(),
    );
  }

  Widget _buildWords() {
    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) {
            return Divider();
          }
          final int index = i ~/ 2;
          if (index >= _words.length) {
            _words.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_words[index]);
        });
  }

  Widget _buildRow(WordPair word) {
    bool isSaved = _saveds.contains(word);
    return ListTile(
      title: Text(
        word.asPascalCase,
        style: _largerFont,
      ),
      trailing: Icon(
        isSaved ? Icons.favorite : Icons.favorite_border,
        color: isSaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (isSaved) {
            _saveds.remove(word);
          } else {
            _saveds.add(word);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      Iterable<ListTile> rows = _saveds.map((word) {
        return ListTile(
          title: Text(word.asPascalCase, style: _largerFont),
        );
      });
      final divideTiles =
          ListTile.divideTiles(context: context, tiles: rows).toList();

      return Scaffold(
        appBar: AppBar(title: Text("收藏夹")),
        body: ListView(children: divideTiles),
      );
    }));
  }
}
