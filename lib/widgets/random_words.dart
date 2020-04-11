import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as English;

class RandomWords extends StatefulWidget {
  static const routeName = '/random_words';

  RandomWords();

  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <English.WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    print('[RandomWords] build');

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
          _suggestions.addAll(English.generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[suggestionIndex]);
      },
    );
  }

  Widget _buildRow(English.WordPair wordPair) {
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}
