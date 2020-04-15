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
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text('Questions'),
            onTap: () {
              Navigator.popAndPushNamed(context, QuestionsPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.watch),
            title: Text('Counter'),
            onTap: () {
              Navigator.popAndPushNamed(context, CounterPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('RandomWords'),
            onTap: () {
              Navigator.popAndPushNamed(context, RandomWordsPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('BlogPosts'),
            onTap: () {
              Navigator.popAndPushNamed(context, BlogPostsPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.wb_sunny),
            title: Text('Weather'),
            onTap: () {
              Navigator.popAndPushNamed(context, WeatherPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
