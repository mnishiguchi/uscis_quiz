import 'package:flutter/material.dart';
import 'package:uscisquiz/pages/counter_page.dart';

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
      body: Center(
        child: RaisedButton(child: Text('Counter'), onPressed: () {
          Navigator.pushNamed(context, CounterPage.routeName);
        },)
      ),
    );
  }
}
