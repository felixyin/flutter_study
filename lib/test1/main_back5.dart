import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "例子",
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _words = <WordPair>[];
  final TextStyle _largerFont = TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "单词本",
          style: TextStyle(fontSize: 28.0),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.list,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: _pushWords)
        ],
      ),
      body: _buildWordsListView(),
    );
  }

  Widget _buildWordsListView() {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final int index = i ~/ 2;
        if (index <= _words.length) {
          _words.addAll(generateWordPairs().take(10));
        }
        return _buildWordListTile(_words[index]);
      },
    );
  }

  Widget _buildWordListTile(WordPair word) {
    final bool alreadySaved = _saved.contains(word);

    return ListTile(
      title: Text(
        word.asPascalCase,
        style: _largerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.redAccent : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved)
            _saved.remove(word);
          else
            _saved.add(word);
        });
      },
    );
  }

  void _pushWords() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final Iterable<ListTile> tiles = _saved.map((word) {
        return ListTile(
          title: Text(
            word.asPascalCase,
            style: _largerFont,
          ),
        );
      });
      final List<Widget> saved =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text(
            "收藏本",
            style: _largerFont,
          ),
        ),
        body: ListView(
          children: saved,
        ),
      );
    }));
  }
}
