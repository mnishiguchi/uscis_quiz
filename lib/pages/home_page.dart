import 'package:flutter/material.dart';

import 'package:uscisquiz/widgets/my_drawer.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    print('[$runtimeType] build');

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('HomePage'),
          ],
        ),
      ),
    );
  }
}
