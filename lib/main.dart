import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:uscisquiz/blocs/blocs.dart';
import 'package:uscisquiz/pages/pages.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      title: 'USCIS Quiz',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.white,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        CounterPage.routeName: (context) => BlocProvider<CounterBloc>(
              create: (context) => CounterBloc(),
              child: CounterPage(title: 'USCIS Quiz Counter Page'),
            ),
        RandomWordsPage.routeName: (context) => RandomWordsPage(),
        BlogPostsPage.routeName: (context) => BlocProvider(
              create: (context) =>
                  // Instantiate the bloc and fetch the initial batch.
                  BlogPostBloc(httpClient: http.Client())..add(BlogPostEventFetch()),
              child: BlogPostsPage(),
            ),
      },
    );
  }
}
