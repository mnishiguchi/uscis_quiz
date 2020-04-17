import 'package:flutter/material.dart';

import 'package:uscisquiz/pages/pages.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('USCIS Quiz'),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('All Questions'),
            onTap: () {
              Navigator.pushReplacementNamed(context, QuestionsPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Bookmarked Questions'),
            onTap: () {
              Navigator.pushReplacementNamed(context, BookmarkedQuestionsPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
