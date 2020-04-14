import 'package:flutter/material.dart';

import 'package:uscisquiz/pages/pages.dart';
import 'package:uscisquiz/widgets/my_drawer.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    print('[HomePage] build');

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
