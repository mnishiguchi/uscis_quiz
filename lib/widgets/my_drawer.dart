import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/pages/pages.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UscisQuizBloc, UscisQuizState>(
      builder: (_, state) {
        final bookmarkCount =
            (state as UscisQuizStateLoaded).bookmarkedIds.length;

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
                  Navigator.pushReplacementNamed(
                      context, QuestionsPage.routeName);
                },
              ),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text('Bookmarked Questions'),
                trailing: Chip(
                  label: Text(bookmarkCount.toString()),
                  labelStyle: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16.0,
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, BookmarkedQuestionsPage.routeName);
                },
              ),
                            ListTile(
                leading: Icon(Icons.help),
                title: Text('About'),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, AboutPage.routeName);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
