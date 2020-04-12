import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart'
    show WordPair, generateWordPairs;

class RandomWordsPage extends StatefulWidget {
  static const routeName = '/random_words';

  RandomWordsPage();

  @override
  RandomWordsPageState createState() => RandomWordsPageState();
}

class RandomWordsPageState extends State<RandomWordsPage> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    print('[RandomWordsPage] build');

    return Scaffold(
      appBar: AppBar(
        title: Text('RandomWordsPage'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          ),
        ],
      ),
      body: Center(
        child: _buildRandomWords(),
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair wordPair) {
              return ListTile(
                title: Text(
                  wordPair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );

          final List<Widget> listItems = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Favorite Phrases'),
            ),
            body: ListView(
              children: listItems,
            ),
          );
        },
      ),
    );
  }

  Widget _buildRandomWords() {
    print('[RandomWordsPageState] _buildRandomWords');

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        // Find next suggestion index ignoring dividers.
        // 0,1,2,3,4,5, ... => 0,0,1,1,2,2,...
        final suggestionIndex = i ~/ 2;

        // If you’ve reached the end of the available word pairings, then
        // generate 10 more and add them to the suggestions list
        if (_suggestions.length <= suggestionIndex) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[suggestionIndex]);
      },
    );
  }

  Widget _buildRow(WordPair wordPair) {
    final bool alreadySaved = _saved.contains(wordPair);

    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(wordPair);
          } else {
            _saved.add(wordPair);
          }
        });
      },
    );
  }
}
