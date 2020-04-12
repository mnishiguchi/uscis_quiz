import 'package:flutter/material.dart';

import 'package:uscisquiz/pages/home_page.dart';
import 'package:uscisquiz/pages/counter_page.dart';
import 'package:uscisquiz/pages/random_words_page.dart';
import 'package:uscisquiz/pages/blog_posts_page.dart';

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
            title: Text('InfiniteList'),
            onTap: () {
              Navigator.popAndPushNamed(context, BlogPostsPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
