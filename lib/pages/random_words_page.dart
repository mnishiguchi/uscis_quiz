import 'package:flutter/material.dart';

import '../widgets/random_words.dart';

class RandomWordsPage extends StatelessWidget {
  static const routeName = '/random_words';

  RandomWordsPage();

  @override
  Widget build(BuildContext context) {
    print('[RandomWordsPage] build');

    return Scaffold(
      appBar: AppBar(
        title: Text('RandomWordsPage'),
      ),
      body: Center(
        child: RandomWords(),
      ),
    );
  }
}
