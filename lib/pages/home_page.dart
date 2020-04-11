import 'package:flutter/material.dart';
import 'package:uscisquiz/pages/counter_page.dart';

import './counter_page.dart';
import './random_words_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  HomePage();

  @override
  Widget build(BuildContext context) {
    print('[HomePage] build');

    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Counter'),
            onPressed: () {
              Navigator.pushNamed(context, CounterPage.routeName);
            },
          ),
          RaisedButton(
            child: Text('Random Words'),
            onPressed: () {
              Navigator.pushNamed(context, RandomWordsPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
