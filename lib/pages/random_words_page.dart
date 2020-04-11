import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWordsPage extends StatelessWidget {
  static const routeName = '/random_words';

  RandomWordsPage();

  @override
  Widget build(BuildContext context) {
    print('[RandomWordsPage] build');

    final wordPair = WordPair.random();

    return Scaffold(
      appBar: AppBar(
        title: Text('RandomWordsPage'),
      ),
      body: Center(
        child: Text(wordPair.asPascalCase),
      ),
    );
  }
}
